#!/usr/bin/perl -W

use strict;

use FindBin;
# With this we will be able to use DCC::Model::CV::Term
use lib "$FindBin::Bin/schema+tools/lib";
use TabParser;
use DCC::Model;

if(scalar(@ARGV)==4) {
	my ($ENSGfile,$OBOENSGfile,$ENSTfile,$OBOENSTfile)=@ARGV;
	
	if(open(my $ENSG,'-|','gunzip','-c',$ENSGfile)) {
		
		my $ENSG_CV = DCC::Model::CV->new();
		my %config = (
			TabParser::TAG_CALLBACK => sub {
				my($ensgene,$version,$desc)=@_;
				$desc = ($desc eq '\\N')?$ensgene:$ensgene.' ('.$desc.')';
				$ENSG_CV->addTerm(DCC::Model::CV::Term->new([$ensgene,$ensgene.'.'.$version],$desc));
			},
			TabParser::TAG_FETCH_COLS => [14,15,10],
			TabParser::TAG_NEG_FILTER => [[1 => 'LRG_gene']],
		);
		TabParser::parseTab($ENSG,%config);
		#$ENSG_CV->validateAndEnactAncestors();
		
		my $comments = <<CEOF;
Generated using $0 from
	$ENSGfile
CEOF
		if(open(my $O,'>',$OBOENSGfile)) {
			$ENSG_CV->OBOserialize($O,$comments);
			close($O);
		} else {
			Carp::croak("Unable to create output file ".$OBOENSGfile);
		}
		close($ENSG);
	} else {
		print STDERR "ERROR: Unable to open EnsEMBL Genes file ".$ENSGfile."\n";
	}
	
	if(open(my $ENST,'-|','gunzip','-c',$ENSTfile)) {
		
		my $ENST_CV = DCC::Model::CV->new();
		my %config = (
			TabParser::TAG_CALLBACK => sub {
				my($enstrans,$version,$desc)=@_;
				$desc = ($desc eq '\\N')?$enstrans:$enstrans.' ('.$desc.')';
				$ENST_CV->addTerm(DCC::Model::CV::Term->new([$enstrans,$enstrans.'.'.$version],$desc));
			},
			TabParser::TAG_FETCH_COLS => [13,14,8],
			TabParser::TAG_NEG_FILTER => [[8 => 'LRG_gene']],
		);
		TabParser::parseTab($ENST,%config);
		#$ENST_CV->validateAndEnactAncestors();
		
		my $comments = <<CEOF;
Generated using $0 from
	$ENSTfile
CEOF
		if(open(my $O,'>',$OBOENSTfile)) {
			$ENST_CV->OBOserialize($O,$comments);
			close($O);
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
ERROR: This program takes as input 4 files:
	- The EnsEMBL gene file
	- The OBO ontology of the EnsEMBL gene file
	- The EnsEMBL transcript file
	- The OBO ontology of the EnsEMBL transcript file
EOF
}