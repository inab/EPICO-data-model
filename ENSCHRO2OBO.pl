#!/usr/bin/perl -W

use strict;

use FindBin;
# With this we will be able to use BP::Model::CV::Term
use lib "$FindBin::Bin/schema+tools/lib";
use TabParser;
use BP::Model;
use BP::Loader::Tools;

use Carp;
use File::Basename qw();
use File::Copy qw();
use File::Spec;
use File::Temp qw();

sub parseCoordS($$$) {
	my($p_coordSystem,$coord_system_id,$coord_type)=@_;
	
	# We only save the first occurrence
	$p_coordSystem->{$coord_type} = $coord_system_id  if(($coord_type eq 'chromosome' || $coord_type eq 'supercontig') && !exists($p_coordSystem->{$coord_type}));
}

sub parseSeqRegions($$$) {
	my($payload,$chroName,$coord_system_id)=@_;
	
	my($p_coordSystemRev,$CHRO_CV)= @{$payload};
	
	if(exists($p_coordSystemRev->{$coord_system_id})) {
		my @chroNames = ( $chroName );
		if($chroName eq 'MT') {
			push(@chroNames,'chrM','M');
		} elsif($chroName =~ /^[1-9][0-9]*$/) {
			push(@chroNames,'chr'.$chroName);
		}
				
		$CHRO_CV->addTerm(BP::Model::CV::Term->new(\@chroNames,$chroName));
	}
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

if(scalar(@ARGV)==2) {
	my($modelFile,$ENSchroName)=@ARGV;
	
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
	
	# Let's get the URIs where the files needed to rebuild the CV are available
	my $ENSchro_fetchURIs = $ENSchro_mCV->uri;
	Carp::croak("ERROR: No available URI for CV $ENSchroName")  unless(ref($ENSchro_fetchURIs) eq 'ARRAY' && scalar(@{$ENSchro_fetchURIs})>0);
	
	# And let's get the output CV file
	my $OBOENSchroFile = $ENSchro_mCV->localFilename;
	Carp::croak("ERROR: Unable to find path for CV $ENSchroName")  unless(defined($OBOENSchroFile));
	
	# Data source version
	my $ver = exists($ENSchro_mCV->annotations->hash->{'data-version'})?$ENSchro_mCV->annotations->hash->{'data-version'}:undef;
	
	# Now, let's create a temp directory where to fetch the files needed to rebuild the CVs
	my $tmpworkdir = File::Temp->newdir();
	my $tmpworkdirname = $tmpworkdir->dirname;
	
	# and, indeed, fetch the associated files to the Ensembl Genes
	my $p_chro_uriFiles = $ENSchro_mCV->mirrorURIs($tmpworkdirname);
	
	# We are expecting two files
	my $coordSFile;
	my $seqRegionFile;
	
	my %mapfiles = (
		'regions'	=> \$seqRegionFile,
		'coords'	=> \$coordSFile
	);
	
	foreach my $pair (@{$p_chro_uriFiles}) {
		${$mapfiles{$pair->[0]->name}} = $pair->[1]  if(exists($mapfiles{$pair->[0]->name}));
	}
	
	Carp::croak("ERROR: Unable to fetch some file")  unless(defined($coordSFile) && defined($seqRegionFile));
	
	my %coordSystem = ();
	if(open(my $CS,'-|',BP::Loader::Tools::GUNZIP,'-c',$coordSFile)) {
		# First, for chromosomes
		my %config = (
			TabParser::TAG_CONTEXT	=> \%coordSystem,
			TabParser::TAG_CALLBACK => \&parseCoordS,
			TabParser::TAG_FETCH_COLS => [0,2],
		);
		TabParser::parseTab($CS,%config);
		
		close($CS);
	} else {
		die("ERROR: Unable to open EnsEMBL coord_system file ".$coordSFile);
	}
	
	if(open(my $SR,'-|',BP::Loader::Tools::GUNZIP,'-c',$seqRegionFile)) {
		my %coordSystemRev = ();
		@coordSystemRev{values(%coordSystem)} = keys(%coordSystem);
		
		my $CHRO_CV = BP::Model::CV->new();
		$CHRO_CV->annotations->addAnnotation('data-version',$ver)  if(defined($ver));
		my %config = (
			TabParser::TAG_CONTEXT	=> [\%coordSystemRev,$CHRO_CV],
			TabParser::TAG_CALLBACK => \&parseSeqRegions,
			TabParser::TAG_FETCH_COLS => [1,2],
		);
		TabParser::parseTab($SR,%config);
		#$CHRO_CV->validateAndEnactAncestors();
		
		my $rel_coordSFile = File::Basename::basename($coordSFile);
		my $rel_seqRegionFile = File::Basename::basename($seqRegionFile);
		my $comments = <<CEOF;
Generated using $0 from
	$rel_coordSFile
	$rel_seqRegionFile
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
	
} else {
	# ftp://ftp.ensembl.org/pub/release-70/mysql/homo_sapiens_core_70_37/coord_system.txt.gz
	# ftp://ftp.ensembl.org/pub/release-70/mysql/homo_sapiens_core_70_37/seq_region.txt.gz
	print STDERR <<EOF;
ERROR: This program takes as input 2 files:
	- The BP model (either in XML or BP format)
	- The Ensembl chromosomes ontology name
EOF
}
