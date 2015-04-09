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

sub parseENSG($$$$) {
	my($ENSG_CV,$ensgene,$version,$desc)=@_;
	$desc = ($desc eq '\\N')?$ensgene:$ensgene.' ('.$desc.')';
	$ENSG_CV->addTerm(BP::Model::CV::Term->new([$ensgene,$ensgene.'.'.$version],$desc));
}

sub parseENST($$$$) {
	my($ENST_CV,$enstrans,$version,$desc)=@_;
	$desc = ($desc eq '\\N')?$enstrans:$enstrans.' ('.$desc.')';
	$ENST_CV->addTerm(BP::Model::CV::Term->new([$enstrans,$enstrans.'.'.$version],$desc));
}

if(scalar(@ARGV)==3) {
	my($modelFile,$ENSGname,$ENSTname)=@ARGV;
	
	my $model = undef;
	eval {
		$model = BP::Model->new($modelFile,undef,1);
	};
	
	if($@) {
		Carp::croak("ERROR: Model loading and validation failed. Reason: ".$@);
	}
	
	# Genes
	my $ENSG_mCV = $model->getNamedCV($ENSGname);
	Carp::croak("ERROR: CV $ENSGname not declared in $modelFile")  unless(defined($ENSG_mCV));
	
	# Let's get the URIs where the files needed to rebuild the CV are available
	my $ENSG_fetchURIs = $ENSG_mCV->uri;
	Carp::croak("ERROR: No available URI for CV $ENSGname")  unless(ref($ENSG_fetchURIs) eq 'ARRAY' && scalar(@{$ENSG_fetchURIs})>0);
	
	# And let's get the output CV file
	my $OBOENSGfile = $ENSG_mCV->localFilename;
	Carp::croak("ERROR: Unable to find path for CV $ENSGname")  unless(defined($OBOENSGfile));
	
	# Transcripts
	my $ENST_mCV = $model->getNamedCV($ENSTname);
	Carp::croak("ERROR: CV $ENSTname not declared in $modelFile")  unless(defined($ENST_mCV));
	
	# Let's get the URIs where the files needed to rebuild the CV are available
	my $ENST_fetchURIs = $ENST_mCV->uri;
	Carp::croak("ERROR: No available URI for CV $ENSTname")  unless(ref($ENST_fetchURIs) eq 'ARRAY' && scalar(@{$ENST_fetchURIs})>0);
	
	# And let's get the output CV file
	my $OBOENSTfile = $ENST_mCV->localFilename;
	Carp::croak("ERROR: Unable to find path for CV $ENSTname")  unless(defined($OBOENSTfile));
	
	
	# Now, let's create a temp directory where to fetch the files needed to rebuild the CVs
	my $tmpworkdir = File::Temp->newdir();
	my $tmpworkdirname = $tmpworkdir->dirname;
	
	# and, indeed, fetch the associated files to the Ensembl Genes
	my $p_G_uriFiles = $ENSG_mCV->mirrorURIs($tmpworkdirname);
	
	# We are expecting only a external resource
	my $ENSGfile = $p_G_uriFiles->[0][1];
	
	if(open(my $ENSG,'-|',BP::Loader::Tools::GUNZIP,'-c',$ENSGfile)) {
		
		my $ENSG_CV = BP::Model::CV->new();
		my $ver = exists($ENSG_mCV->annotations->hash->{'data-version'})?$ENSG_mCV->annotations->hash->{'data-version'}:undef;
		$ENSG_CV->annotations->addAnnotation('data-version',$ver)  if(defined($ver));
		my $is79 =  defined($ver) && $ver >= 79;
		my %config = (
			TabParser::TAG_CONTEXT	=> $ENSG_CV,
			TabParser::TAG_CALLBACK => \&parseENSG,
			TabParser::TAG_FETCH_COLS => ($is79?[13,14,10]:[14,15,10]),
			TabParser::TAG_NEG_FILTER => [[1 => 'LRG_gene']],
		);
		TabParser::parseTab($ENSG,%config);
		#$ENSG_CV->validateAndEnactAncestors();
		
		my $relENSGfile = File::Basename::basename($ENSGfile);
		my $comments = <<CEOF;
Generated using $0 from
	$relENSGfile
CEOF
		my $tmpOBOENSGfile = File::Spec->catfile($tmpworkdirname,File::Basename::basename($OBOENSGfile));
		if(open(my $O,'>',$tmpOBOENSGfile)) {
			$ENSG_CV->OBOserialize($O,$comments);
			close($O);
			File::Copy::move($tmpOBOENSGfile,$OBOENSGfile);
		} else {
			Carp::croak("Unable to create output file ".$OBOENSGfile);
		}
		close($ENSG);
	} else {
		print STDERR "ERROR: Unable to open EnsEMBL Genes file ".$ENSGfile."\n";
	}
	
	# Now, the transcripts
	# Fetch the associated files to the Ensembl Transcripts
	my $p_T_uriFiles = $ENST_mCV->mirrorURIs($tmpworkdirname);
	
	# We are expecting only a external resource
	my $ENSTfile = $p_T_uriFiles->[0][1];
	
	if(open(my $ENST,'-|',BP::Loader::Tools::GUNZIP,'-c',$ENSTfile)) {
		
		my $ENST_CV = BP::Model::CV->new();
		my $ver = exists($ENST_mCV->annotations->hash->{'data-version'})?$ENST_mCV->annotations->hash->{'data-version'}:undef;
		$ENST_CV->annotations->addAnnotation('data-version',$ver)  if(defined($ver));
		my $is79 =  defined($ver) && $ver >= 79;
		my %config = (
			TabParser::TAG_CONTEXT	=> $ENST_CV,
			TabParser::TAG_CALLBACK => \&parseENST,
			TabParser::TAG_FETCH_COLS => ($is79?[14,15,9]:[13,14,8]),
			TabParser::TAG_NEG_FILTER => [[($is79?9:8) => 'LRG_gene']],
		);
		TabParser::parseTab($ENST,%config);
		#$ENST_CV->validateAndEnactAncestors();
		
		my $relENSTfile = File::Basename::basename($ENSTfile);
		my $comments = <<CEOF;
Generated using $0 from
	$relENSTfile
CEOF
		my $tmpOBOENSTfile = File::Spec->catfile($tmpworkdirname,File::Basename::basename($OBOENSTfile));
		if(open(my $O,'>',$tmpOBOENSTfile)) {
			$ENST_CV->OBOserialize($O,$comments);
			close($O);
			File::Copy::move($tmpOBOENSTfile,$OBOENSTfile);
		} else {
			Carp::croak("Unable to create output file ".$OBOENSTfile);
		}
		close($ENST);
	} else {
		print STDERR "ERROR: Unable to open EnsEMBL Transcripts file ".$ENSTfile."\n";
	}
	
} else {
	# ftp://ftp.ensembl.org/pub/release-70/mysql/homo_sapiens_core_70_37/gene.txt.gz
	# ftp://ftp.ensembl.org/pub/release-70/mysql/homo_sapiens_core_70_37/transcript.txt.gz
	print STDERR <<EOF;
ERROR: This program takes as input 3 parameters:
	- The BP model (either in XML or BP format)
	- The EnsEMBL gene ontology name
	- The EnsEMBL transcript ontology name
EOF
}
