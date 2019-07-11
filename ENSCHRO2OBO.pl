#!/usr/bin/perl

use strict;
use warnings 'all';
use File::Spec;
use FindBin;
# With this we will be able to use BP::Model::CV::Term and others
use lib File::Spec->catdir($FindBin::Bin,'local','lib','perl5');

use TabParser;
use BP::Model;
use BP::Loader::Tools;

use Carp;
use File::Basename qw();
use File::Copy qw();
use File::Spec;
use File::Temp qw();

sub parseAccession2chrUCSC($$$$) {
	# Sequence-Name
	# Sequence-Role
	# Assigned-Molecule
	# Assigned-Molecule-Location/Type
	# GenBank-Accn
	# Relationship
	# RefSeq-Accn
	# Assembly-Unit
	# UCSC-style-name
	my($payload,$chro_scaffold_name,$chro_scaffold_role,undef,$type,$acc,undef,undef,undef,$UCSCname)=@_;
	
	my($p_scaffold2chrUCSC,$p_scaffold2chr) = @{$payload};
	
	$UCSCname = 'chr'.$chro_scaffold_name  if(!defined($UCSCname) && $chro_scaffold_role eq 'assembled-molecule' && $type eq 'Chromosome');
	
	my $val = [$acc,$UCSCname,$chro_scaffold_name];
	$p_scaffold2chrUCSC->{$acc} = $val;
	$p_scaffold2chr->{$chro_scaffold_name} = $val;
	
	1;
}

sub parseCoordS_chro($$$) {
	my($p_coordSystem,$coord_system_id,$coord_type)=@_;
	
	# We only save the first occurrence
	$p_coordSystem->{$coord_type} = $coord_system_id  if(($coord_type eq 'chromosome' || $coord_type eq 'supercontig') && !exists($p_coordSystem->{$coord_type}));
}

sub parseCoordS_scaffold($$$) {
	my($p_coordSystem,$coord_system_id,$coord_type)=@_;
	
	# We only save the first occurrence
	$p_coordSystem->{$coord_type} = $coord_system_id  if($coord_type eq 'scaffold' && !exists($p_coordSystem->{$coord_type}));
}

sub parseSeqRegions($$$) {
	my($payload,$name,$coord_system_id)=@_;
	
	my($p_coordSystemRev,$p_scaffold2chrUCSC,$CV,$p_scaffold2chrUCSC_alt,$CHRO_CV)= @{$payload};
	
	if(exists($p_coordSystemRev->{$coord_system_id})) {
		unless($CHRO_CV && $CHRO_CV->getTerm($name)) {
			my $p_Names;
			my $altName;
			
			$altName = substr($name,length('CHR_'))  if(index($name,'CHR_')==0);
			
			if(exists($p_scaffold2chrUCSC->{$name}) || (defined($altName) && exists($p_scaffold2chrUCSC->{$altName}))) {
				my $theName = exists($p_scaffold2chrUCSC->{$name}) ? $name : $altName;
				my $doAddName = !exists($p_scaffold2chrUCSC->{$name});
				
				$p_Names =  $p_scaffold2chrUCSC->{$theName};
				
				delete($p_scaffold2chrUCSC->{$theName});
				if(defined($p_scaffold2chrUCSC_alt)) {
					delete($p_scaffold2chrUCSC_alt->{$p_Names->[0]});
					
					# Swapping main name
					my $tmp = $p_Names->[0];
					$p_Names->[0] = $p_Names->[2];
					$p_Names->[2] = $tmp;
				}
				
				# Now, regenerate removing undefs
				my @cleansedNames = ();
				foreach my $cName (@{$p_Names}) {
					push(@cleansedNames,$cName)  if(defined($cName));
				}
				$p_Names = \@cleansedNames;
				
				unshift(@{$p_Names},$name)  if($doAddName);
				push(@{$p_Names},'M')  if($name eq 'MT');
			} else {
				my @Names = ( $name );
				if($name eq 'MT') {
					push(@Names,'chrM','M');
				} elsif($name eq 'X' || $name eq 'Y') {
					push(@Names,'chr'.$name);
				} elsif($name =~ /^[1-9][0-9]*$/) {
					push(@Names,'chr'.$name);
				}
				$p_Names = \@Names;
			}
			
			
			$CV->addTerm(BP::Model::CV::Term->new($p_Names,$name));
		}
	}
	
	1;
}

sub sortChro($$) {
	if($_[0] =~ /^[1-9][0-9]*$/) {
		return ($_[1] =~ /^[1-9][0-9]*$/)?$_[0] <=> $_[1]:-1;
	} elsif($_[1] =~ /^[1-9][0-9]*$/) {
		return 1;
	} else {
		return (length($_[0])==length($_[1])) ? $_[0] cmp $_[1] : length($_[0]) <=> length($_[1]);
	}
}

if(scalar(@ARGV)==3) {
	my($modelFile,$ENSchroName,$ENSscaffoldName)=@ARGV;
	
	my $model = undef;
	eval {
		$model = BP::Model->new($modelFile,undef,1);
	};
	
	if($@) {
		Carp::croak("ERROR: Model loading and validation failed. Reason: ".$@);
	}
	
	# Genes
	my $ENSchro_mCV = $model->getNamedCV($ENSchroName);
	Carp::croak("ERROR: CV $ENSchroName not declared in $modelFile")  unless(defined($ENSchro_mCV));
	
	my $ENSscaffold_mCV = $model->getNamedCV($ENSscaffoldName);
	Carp::croak("ERROR: CV $ENSscaffoldName not declared in $modelFile")  unless(defined($ENSscaffold_mCV));
	
	# Let's get the URIs where the files needed to rebuild the CV are available
	my $ENSchro_fetchURIs = $ENSchro_mCV->uri;
	Carp::croak("ERROR: No available URI for CV $ENSchroName")  unless(ref($ENSchro_fetchURIs) eq 'ARRAY' && scalar(@{$ENSchro_fetchURIs})>0);
	
	# And let's get the output CV file
	my $OBOENSchroFile = $ENSchro_mCV->localFilename;
	Carp::croak("ERROR: Unable to find path for CV $ENSchroName")  unless(defined($OBOENSchroFile));
	
	# Let's get the URIs where the files needed to rebuild the CV are available
	my $ENSscaffold_fetchURIs = $ENSscaffold_mCV->uri;
	Carp::croak("ERROR: No available URI for CV $ENSscaffoldName")  unless(ref($ENSscaffold_fetchURIs) eq 'ARRAY' && scalar(@{$ENSscaffold_fetchURIs})>0);
	
	# And let's get the output CV file
	my $OBOENSscaffoldFile = $ENSscaffold_mCV->localFilename;
	Carp::croak("ERROR: Unable to find path for CV $ENSscaffoldName")  unless(defined($OBOENSscaffoldFile));
	
	# Data source version
	my $ENSchro_ver = exists($ENSchro_mCV->annotations->hash->{'data-version'})?$ENSchro_mCV->annotations->hash->{'data-version'}:undef;
	my $ENSscaffold_ver = exists($ENSscaffold_mCV->annotations->hash->{'data-version'})?$ENSscaffold_mCV->annotations->hash->{'data-version'}:undef;
	
	# Now, let's create a temp directory where to fetch the files needed to rebuild the CVs
	my $tmpworkdir = File::Temp->newdir();
	my $tmpworkdirname = $tmpworkdir->dirname;
	
	# and, indeed, fetch the associated files to the Ensembl Genes
	my $p_chro_uriFiles = $ENSchro_mCV->mirrorURIs($tmpworkdirname);
	# and, indeed, fetch the associated files to the Ensembl Scaffolds
	my $p_scaffold_uriFiles = $ENSscaffold_mCV->mirrorURIs($tmpworkdirname);
	
	# We are expecting two files
	my $coordSFile;
	my $seqRegionFile;
	my $GRC_acc2nameFile;
	
	my %mapfiles = (
		'regions'	=> \$seqRegionFile,
		'coords'	=> \$coordSFile,
		'GRC_acc2name'	=> \$GRC_acc2nameFile,
	);
	
	# Map for chromosomes
	foreach my $pair (@{$p_chro_uriFiles}) {
		${$mapfiles{$pair->[0]->name}} = $pair->[1]  if(exists($mapfiles{$pair->[0]->name}));
	}
	
	Carp::croak("ERROR: Unable to fetch some file")  unless(defined($coordSFile) && defined($seqRegionFile));
	
	my %scaffold2chrUCSC = ();
	my %scaffold2chr = ();
	if(open(my $SC2UCSC,'<',$GRC_acc2nameFile)) {
		# First, for name mappings
		my %config = (
			TabParser::TAG_CONTEXT	=> [\%scaffold2chrUCSC,\%scaffold2chr],
			TabParser::TAG_CALLBACK => \&parseAccession2chrUCSC,
			TabParser::TAG_COMMENT	=>	'#',
			TabParser::TAG_VERBOSE	=>	1,
		);
		TabParser::parseTab($SC2UCSC,%config);
		
		close($SC2UCSC);
	} else {
		die("ERROR: Unable to open GRCh acc2name file ".$GRC_acc2nameFile);
	}
	
	my %coordSystem_chro = ();
	if(open(my $CS,'-|',BP::Loader::Tools::GUNZIP,'-c',$coordSFile)) {
		# First, for chromosomes
		my %config = (
			TabParser::TAG_CONTEXT	=> \%coordSystem_chro,
			TabParser::TAG_CALLBACK => \&parseCoordS_chro,
			TabParser::TAG_FETCH_COLS => [0,2],
		);
		TabParser::parseTab($CS,%config);
		
		close($CS);
	} else {
		die("ERROR: Unable to open EnsEMBL coord_system file ".$coordSFile);
	}
	
	my %coordSystem_scaffold = ();
	if(open(my $CS,'-|',BP::Loader::Tools::GUNZIP,'-c',$coordSFile)) {
		# Second, for scaffolds
		my %config = (
			TabParser::TAG_CONTEXT	=> \%coordSystem_scaffold,
			TabParser::TAG_CALLBACK => \&parseCoordS_scaffold,
			TabParser::TAG_FETCH_COLS => [0,2],
		);
		TabParser::parseTab($CS,%config);
		
		close($CS);
	} else {
		die("ERROR: Unable to open EnsEMBL coord_system file ".$coordSFile);
	}
	
	my $CHRO_CV = BP::Model::CV->new();
	if(open(my $SR,'-|',BP::Loader::Tools::GUNZIP,'-c',$seqRegionFile)) {
		my %coordSystemRev = ();
		@coordSystemRev{values(%coordSystem_chro)} = keys(%coordSystem_chro);
		
		$CHRO_CV->annotations->addAnnotation('data-version',$ENSchro_ver)  if(defined($ENSchro_ver));
		my %config = (
			TabParser::TAG_CONTEXT	=> [\%coordSystemRev,\%scaffold2chr,$CHRO_CV,\%scaffold2chrUCSC],
			TabParser::TAG_CALLBACK => \&parseSeqRegions,
			TabParser::TAG_FETCH_COLS => [1,2],
		);
		TabParser::parseTab($SR,%config);
		#$CHRO_CV->validateAndEnactAncestors();
		
		my $rel_coordSFile = File::Basename::basename($coordSFile);
		my $rel_seqRegionFile = File::Basename::basename($seqRegionFile);
		my $rel_GRC_acc2nameFile = File::Basename::basename($GRC_acc2nameFile);
		my $comments = <<CEOF;
Generated using $0 from
	$rel_coordSFile
	$rel_seqRegionFile
	$rel_GRC_acc2nameFile
CEOF
		my $tmpOBOENSchroFile = File::Spec->catfile($tmpworkdirname,File::Basename::basename($OBOENSchroFile));
		if(open(my $O,'>',$tmpOBOENSchroFile)) {
			$CHRO_CV->OBOserialize($O,$comments,\&sortChro);
			close($O);
			File::Copy::move($tmpOBOENSchroFile,$OBOENSchroFile);
		} else {
			Carp::croak("Unable to create output file ".$OBOENSchroFile);
		}
		close($SR);
	} else {
		print STDERR "ERROR: Unable to open EnsEMBL seq_region file ".$seqRegionFile."\n";
	}
	
	if(open(my $SR,'-|',BP::Loader::Tools::GUNZIP,'-c',$seqRegionFile)) {
		my %coordSystemRev = ();
		@coordSystemRev{values(%coordSystem_scaffold)} = keys(%coordSystem_scaffold);
		
		my $SCAFFOLD_CV = BP::Model::CV->new();
		$SCAFFOLD_CV->annotations->addAnnotation('data-version',$ENSscaffold_ver)  if(defined($ENSscaffold_ver));
		my %config = (
			TabParser::TAG_CONTEXT	=> [\%coordSystemRev,\%scaffold2chrUCSC,$SCAFFOLD_CV,undef,$CHRO_CV],
			TabParser::TAG_CALLBACK => \&parseSeqRegions,
			TabParser::TAG_FETCH_COLS => [1,2],
		);
		TabParser::parseTab($SR,%config);
		close($SR);
		#$SCAFFOLD_CV->validateAndEnactAncestors();
		
		print "INFO: Unmapped scaffold2chrUCSC entries: ",scalar(keys(%scaffold2chrUCSC)),"\n";
		foreach my $val (values(%scaffold2chrUCSC)) {
			print STDERR join("\t",'',@{$val}),"\n";
		}
		
		my $rel_coordSFile = File::Basename::basename($coordSFile);
		my $rel_seqRegionFile = File::Basename::basename($seqRegionFile);
		my $rel_GRC_acc2nameFile = File::Basename::basename($GRC_acc2nameFile);
		my $comments = <<CEOF;
Generated using $0 from
	$rel_coordSFile
	$rel_seqRegionFile
	$rel_GRC_acc2nameFile
CEOF
		my $tmpOBOENSscaffoldFile = File::Spec->catfile($tmpworkdirname,File::Basename::basename($OBOENSscaffoldFile));
		if(open(my $O,'>',$tmpOBOENSscaffoldFile)) {
			$SCAFFOLD_CV->OBOserialize($O,$comments);
			close($O);
			File::Copy::move($tmpOBOENSscaffoldFile,$OBOENSscaffoldFile);
		} else {
			Carp::croak("Unable to create output file ".$OBOENSscaffoldFile);
		}
	} else {
		print STDERR "ERROR: Unable to open EnsEMBL seq_region file ".$seqRegionFile."\n";
	}
} else {
	# ftp://ftp.ensembl.org/pub/release-79/mysql/homo_sapiens_core_79_38/coord_system.txt.gz
	# ftp://ftp.ensembl.org/pub/release-79/mysql/homo_sapiens_core_79_38/seq_region.txt.gz
	# ftp://ftp.ncbi.nlm.nih.gov/genbank/genomes/Eukaryotes/vertebrates_mammals/Homo_sapiens/GRCh38/GCA_000001405.15_GRCh38_top-level.acc2name
	print STDERR <<EOF;
ERROR: This program takes as input 3 parameters:
	- The BP model (either in XML or BP format)
	- The Ensembl chromosomes ontology name
	- The Ensembl scaffolds ontology name
EOF
}
