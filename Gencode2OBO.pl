#!/usr/bin/perl -W

use strict;

use FindBin;
# With this we will be able to use BP::Model::CV::Term
use lib "$FindBin::Bin/schema+tools/lib";
use TabParser;
use BP::Model;
use BP::Loader::Tools;

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

if(scalar(@ARGV)>=3) {
	my $class3File = undef;
	my $GencodeGfile = undef;
	my $GencodeTfile = undef;
	my $OBOGencodeGfile = undef;
	my $OBOGencodeTfile = undef;
	
	if(scalar(@ARGV)==3) {
		($class3File,$OBOGencodeGfile,$OBOGencodeTfile) = @ARGV;
		$GencodeGfile = $GencodeTfile = $class3File;
	} else {
		($GencodeGfile,$GencodeTfile,$OBOGencodeGfile,$OBOGencodeTfile) = @ARGV;
	}
	
	my $GencodeG_CV = BP::Model::CV->new();
	my $GencodeT_CV = BP::Model::CV->new();
	
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
	
	if(open(my $O,'>',$OBOGencodeGfile)) {
		my $comments = <<CEOF;
Generated using $0 from
	$GencodeGfile
CEOF
		$GencodeG_CV->OBOserialize($O,$comments);
		close($O);
	} else {
		Carp::croak("Unable to create output file ".$OBOGencodeGfile." due $!");
	}
	if(open(my $O,'>',$OBOGencodeTfile)) {
		my $comments = <<CEOF;
Generated using $0 from
	$GencodeTfile
CEOF
		$GencodeT_CV->OBOserialize($O,$comments);
		close($O);
	} else {
		Carp::croak("Unable to create output file ".$OBOGencodeTfile." due $!");
	}
} else {
	print STDERR <<EOF;
ERROR: This program takes as input either 3 or 4 files:
	- The Gencode genes and transcripts class3 file (Gencode15 and below)
	
	or
	
	- The Gencode genes file (Gencode16 and above)
	- The Gencode transcripts file (Gencode16 and above)
	
	and
	
	- The output OBO ontology with the Gencode genes
	- The output OBO ontology with the Gencode transcripts
EOF
}
