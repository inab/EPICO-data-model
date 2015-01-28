#!/usr/bin/perl -W

use strict;

use FindBin;
# With this we will be able to use BP::Model::CV::Term
use lib "$FindBin::Bin/schema+tools/lib";
use TabParser;
use BP::Model;


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

if(scalar(@ARGV)==3) {
	my ($coordSFile,$seqRegionFile,$OBOfile)=@ARGV;
	
	my %coordSystem = ();
	if(open(my $CS,'-|','gunzip','-c',$coordSFile)) {
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
	
	if(open(my $SR,'-|','gunzip','-c',$seqRegionFile)) {
		my %coordSystemRev = ();
		@coordSystemRev{values(%coordSystem)} = keys(%coordSystem);
		
		my $CHRO_CV = BP::Model::CV->new();
		my %config = (
			TabParser::TAG_CONTEXT	=> [\%coordSystemRev,$CHRO_CV],
			TabParser::TAG_CALLBACK => \&parseSeqRegions,
			TabParser::TAG_FETCH_COLS => [1,2],
		);
		TabParser::parseTab($SR,%config);
		#$CHRO_CV->validateAndEnactAncestors();
		
		my $comments = <<CEOF;
Generated using $0 from
	$coordSFile
	$seqRegionFile
CEOF
		if(open(my $O,'>',$OBOfile)) {
			$CHRO_CV->OBOserialize($O,$comments);
			close($O);
		} else {
			Carp::croak("Unable to create output file ".$OBOfile);
		}
		close($SR);
	} else {
		print STDERR "ERROR: Unable to open EnsEMBL seq_region file ".$seqRegionFile."\n";
	}
	
} else {
	# ftp://ftp.ensembl.org/pub/release-70/mysql/homo_sapiens_core_70_37/coord_system.txt.gz
	# ftp://ftp.ensembl.org/pub/release-70/mysql/homo_sapiens_core_70_37/seq_region.txt.gz
	print STDERR <<EOF;
ERROR: This program takes as input 3 files:
	- The EnsEMBL coord_system file
	- The EnsEMBL seq_region file
	- The OBO ontology of the EnsEMBL chromosomes and genome patches file
EOF
}
