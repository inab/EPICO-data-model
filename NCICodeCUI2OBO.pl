#!/usr/bin/perl

use strict;
use warnings 'all';
use File::Spec;
use FindBin;
# With this we will be able to use BP::Model::CV::Term and others
use lib File::Spec->catdir($FindBin::Bin,'local','lib','perl5');

use Carp;
use File::Basename;
use File::Copy;
use File::Spec;
use File::Temp qw();
use LWP::UserAgent;
use URI;

use BP::Model;
use TabParser;

sub parseNCIm($$$$$) {
	my($NCImCV,$nci_code,$NCImCUI,$nci_code_desc,$NCImCUIDesc)=@_;
	
	$NCImCV->addTerm(BP::Model::CV::Term->new([$NCImCUI,$nci_code],$NCImCUIDesc));
}

if(scalar(@ARGV)==2) {
	my($modelFile,$NCImName)=@ARGV;
	
	my $model = undef;
	eval {
		$model = BP::Model->new($modelFile,undef,1);
	};
	
	if($@) {
		Carp::croak("ERROR: Model loading and validation failed. Reason: ".$@);
	}
	
	my $NCIm_mCV = $model->getNamedCV($NCImName);
	Carp::croak("ERROR: CV $NCImName not declared in $modelFile")  unless(defined($NCIm_mCV));
	
	# Let's get the URIs where the files needed to rebuild the CV are available
	my $NCIm_fetchURIs = $NCIm_mCV->uri;
	Carp::croak("ERROR: No available URI for CV $NCImName")  unless(ref($NCIm_fetchURIs) eq 'ARRAY' && scalar(@{$NCIm_fetchURIs})>0);
	
	# And let's get the output CV file
	my $outputFile = $NCIm_mCV->localFilename;
	Carp::croak("ERROR: Unable to find path for CV $NCImName")  unless(defined($outputFile));

	# Now, let's create a temp directory where to fetch the files needed to rebuild the CVs
	my $tmpworkdir = File::Temp->newdir();
	my $tmpworkdirname = $tmpworkdir->dirname;
	
	my @NCIuris = map { $_->uri } @{$NCIm_fetchURIs};
	print "Step 1: fetching ".join(' ',@NCIuris)."\n";
	# and, indeed, fetch the associated files to the Ensembl Genes
	my $p_N_uriFiles = $NCIm_mCV->mirrorURIs($tmpworkdirname);
	
	my $nci_code_cui_map_local = $p_N_uriFiles->[0][1];

	my $NCImCV = BP::Model::CV->new();
	my $ver = exists($NCIm_mCV->annotations->hash->{'data-version'})?$NCIm_mCV->annotations->hash->{'data-version'}:undef;
	$NCImCV->annotations->addAnnotation('data-version',$ver)  if(defined($ver));
	
	print "Step 2: parsing NCI codes to CUI dump\n";
	if(open(my $NCI,'<:encoding(UTF-8)',$nci_code_cui_map_local)) {
		my %config = (
			TabParser::TAG_CONTEXT	=> $NCImCV,
			TabParser::TAG_CALLBACK => \&parseNCIm,
			TabParser::TAG_SEP	=> qr/\|/,
		);
		TabParser::parseTab($NCI,%config);

		print "Writing to $outputFile\n";
		my $comments = <<CEOF;
Generated using $0 from
	$NCIuris[0]
CEOF
		my $tmpOBONCImfile = File::Spec->catfile($tmpworkdirname,File::Basename::basename($outputFile));
		if(open(my $O,'>:encoding(UTF-8)',$tmpOBONCImfile)) {
			$NCImCV->OBOserialize($O,$comments);
			close($O);
			File::Copy::move($tmpOBONCImfile,$outputFile);
		} else {
			Carp::croak("Unable to create output file ".$outputFile);
		}

		close($NCI);
	}
	
} else {
	print STDERR <<EOF
ERROR: This program takes two parameters:
	- The BP model (either in XML or BP format)
	- The NCI Metathesaurus CV name in the model
EOF
}
