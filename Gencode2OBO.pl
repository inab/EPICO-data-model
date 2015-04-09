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

sub parseClass3(\@$$$) {
	my($pCV,$ensGene,$ensTranscript,$descEnsGene,$descEnsTranscript)=@_;
	
	if($ensGene ne $pCV->[2]) {
		$pCV->[2] = $ensGene;
		my($ensGeneId,$ensGeneVersion)=split(/\./,$ensGene,2);
		$pCV->[0]->addTerm(BP::Model::CV::Term->new([$ensGeneId,$ensGene],"$ensGeneId ($descEnsGene)"));
	}
	
	my($ensTranscriptId,$ensTranscriptVersion)=split(/\./,$ensTranscript,2);
	$pCV->[1]->addTerm(BP::Model::CV::Term->new([$ensTranscriptId,$ensTranscript],"$ensTranscriptId ($descEnsTranscript)"));
}

sub parseGencodeDump($$$$) {
	my($Gencode_CV,$ens,$desc)=@_;
	
	my($ensId,$ensVersion)=split(/\./,$ens,2);
	
	$Gencode_CV->addTerm(BP::Model::CV::Term->new([$ensId,$ens],"$ensId ($desc)"));
}

# Class3 parser is needed for Gencode versions below 16
if(scalar(@ARGV)==3) {
	my($modelFile,$GencodeGname,$GencodeTname)=@ARGV;
	
	my $model = undef;
	eval {
		$model = BP::Model->new($modelFile,undef,1);
	};
	
	if($@) {
		Carp::croak("ERROR: Model loading and validation failed. Reason: ".$@);
	}
	
	# Genes
	my $GencodeG_mCV = $model->getNamedCV($GencodeGname);
	Carp::croak("ERROR: CV $GencodeGname not declared in $modelFile")  unless(defined($GencodeG_mCV));
	
	# Let's get the URIs where the files needed to rebuild the CV are available
	my $GencodeG_fetchURIs = $GencodeG_mCV->uri;
	Carp::croak("ERROR: No available URI for CV $GencodeGname")  unless(ref($GencodeG_fetchURIs) eq 'ARRAY' && scalar(@{$GencodeG_fetchURIs})>0);
	
	# And let's get the output CV file
	my $OBOGencodeGfile = $GencodeG_mCV->localFilename;
	Carp::croak("ERROR: Unable to find path for CV $GencodeGname")  unless(defined($OBOGencodeGfile));
	
	# Data source version
	my $gVer = exists($GencodeG_mCV->annotations->hash->{'data-version'})?$GencodeG_mCV->annotations->hash->{'data-version'}:undef;
	
	# Transcripts
	my $GencodeT_mCV = $model->getNamedCV($GencodeTname);
	Carp::croak("ERROR: CV $GencodeTname not declared in $modelFile")  unless(defined($GencodeT_mCV));
	
	# Let's get the URIs where the files needed to rebuild the CV are available
	my $GencodeT_fetchURIs = $GencodeT_mCV->uri;
	Carp::croak("ERROR: No available URI for CV $GencodeTname")  unless(ref($GencodeT_fetchURIs) eq 'ARRAY' && scalar(@{$GencodeT_fetchURIs})>0);
	
	# And let's get the output CV file
	my $OBOGencodeTfile = $GencodeT_mCV->localFilename;
	Carp::croak("ERROR: Unable to find path for CV $GencodeTname")  unless(defined($OBOGencodeTfile));
	
	
	# Now, let's create a temp directory where to fetch the files needed to rebuild the CVs
	my $tmpworkdir = File::Temp->newdir();
	my $tmpworkdirname = $tmpworkdir->dirname;
	
	# and, indeed, fetch the associated files to the Gencode Genes
	my $p_G_uriFiles = $GencodeG_mCV->mirrorURIs($tmpworkdirname);
	
	# We are expecting a single external resource
	my $GencodeGfile = $p_G_uriFiles->[0][1];
	my $class3File = ($p_G_uriFiles->[0][0]->format eq 'GencodeLevel3Classes') ? $GencodeGfile : undef;
	
	# For the comments
	my $genGencodeGfile = File::Basename::basename($GencodeGfile);
	my $genGencodeTfile = defined($class3File) ? $genGencodeGfile : undef;

	# Data source version
	my $tVer = defined($class3File)? $gVer : (exists($GencodeG_mCV->annotations->hash->{'data-version'})?$GencodeG_mCV->annotations->hash->{'data-version'}:undef);
	
	my $GencodeG_CV = BP::Model::CV->new();
	$GencodeG_CV->annotations->addAnnotation('data-version',$gVer)  if(defined($gVer));
	my $GencodeT_CV = BP::Model::CV->new();
	$GencodeT_CV->annotations->addAnnotation('data-version',$tVer)  if(defined($tVer));
	
	my $openMode = undef;
	my @command = ();
	
	if(defined($class3File)) {
		if($class3File =~ /\.gz$/) {
			$openMode = '-|';
			@command = (BP::Loader::Tools::GUNZIP,'-c',$class3File);
		} else {
			$openMode = '<';
			@command = ($class3File);
		}
		
		if(open(my $C3,$openMode,@command)) {
			
			my %config = (
				TabParser::TAG_CONTEXT	=> [$GencodeG_CV,$GencodeT_CV,''],
				TabParser::TAG_CALLBACK => \&parseClass3,
				TabParser::TAG_FETCH_COLS => [0,1,2,4],
			);
			TabParser::parseTab($C3,%config);
			#$GencodeG_CV->validateAndEnactAncestors();
			#$GencodeT_CV->validateAndEnactAncestors();
			close($C3);
			
		} else {
			print STDERR "ERROR: Unable to open Gencode genes and transcripts file ".$class3File." due $!\n";
		}
	} else {
		if($GencodeGfile =~ /\.gz$/) {
			$openMode = '-|';
			@command = (BP::Loader::Tools::GUNZIP,'-c',$GencodeGfile);
		} else {
			$openMode = '<';
			@command = ($GencodeGfile);
		}
		
		if(open(my $GG,$openMode,@command)) {
			my %config = (
				TabParser::TAG_CONTEXT	=> $GencodeG_CV,
				TabParser::TAG_CALLBACK => \&parseGencodeDump,
			);
			TabParser::parseTab($GG,%config);
			#$GencodeG_CV->validateAndEnactAncestors();
			close($GG);
		} else {
			print STDERR "ERROR: Unable to open Gencode genes file ".$GencodeGfile." due $!\n";
		}
		
		# Fetch the associated files to the Gencode Transcripts
		my $p_T_uriFiles = $GencodeT_mCV->mirrorURIs($tmpworkdirname);
		
		# We are expecting a single external resource
		my $GencodeTfile = $p_T_uriFiles->[0][1];
		$genGencodeTfile = File::Basename::basename($GencodeTfile);
		if($GencodeTfile =~ /\.gz$/) {
			$openMode = '-|';
			@command = (BP::Loader::Tools::GUNZIP,'-c',$GencodeTfile);
		} else {
			$openMode = '<';
			@command = ($GencodeTfile);
		}
		
		if(open(my $GT,$openMode,@command)) {
			my %config = (
				TabParser::TAG_CONTEXT	=> $GencodeT_CV,
				TabParser::TAG_CALLBACK => \&parseGencodeDump,
			);
			TabParser::parseTab($GT,%config);
			#$GencodeT_CV->validateAndEnactAncestors();
			close($GT);
		} else {
			print STDERR "ERROR: Unable to open Gencode transcripts file ".$GencodeTfile." due $!\n";
		}
	}
	
	my $tmpOBOGencodeGfile = File::Spec->catfile($tmpworkdirname,File::Basename::basename($OBOGencodeGfile));
	if(open(my $O,'>',$tmpOBOGencodeGfile)) {
		my $comments = <<CEOF;
Generated using $0 from
	$genGencodeGfile
CEOF
		$GencodeG_CV->OBOserialize($O,$comments);
		close($O);
		File::Copy::move($tmpOBOGencodeGfile,$OBOGencodeGfile);
	} else {
		Carp::croak("Unable to create output file ".$OBOGencodeGfile." due $!");
	}
	my $tmpOBOGencodeTfile = File::Spec->catfile($tmpworkdirname,File::Basename::basename($OBOGencodeTfile));
	if(open(my $O,'>',$tmpOBOGencodeTfile)) {
		my $comments = <<CEOF;
Generated using $0 from
	$genGencodeTfile
CEOF
		$GencodeT_CV->OBOserialize($O,$comments);
		close($O);
		File::Copy::move($tmpOBOGencodeTfile,$OBOGencodeTfile);
	} else {
		Carp::croak("Unable to create output file ".$OBOGencodeTfile." due $!");
	}
} else {
	print STDERR <<EOF;
ERROR: This program takes as input 3 parameters:
	- The BP model (either in XML or BP format)
	- The Gencode genes ontology name
	- The Gencode transcripts ontology name
EOF
}
