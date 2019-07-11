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
use XML::LibXML;

use BP::Model;

if(scalar(@ARGV)==2) {
	my($modelFile,$ISO3166Name)=@ARGV;
	
	my $model = undef;
	eval {
		$model = BP::Model->new($modelFile,undef,1);
	};
	
	if($@) {
		Carp::croak("ERROR: Model loading and validation failed. Reason: ".$@);
	}
	
	my $ISO3166_mCV = $model->getNamedCV($ISO3166Name);
	Carp::croak("ERROR: CV $ISO3166Name not declared in $modelFile")  unless(defined($ISO3166_mCV));
	
	# Let's get the URIs where the files needed to rebuild the CV are available
	my $ISO3166_fetchURIs = $ISO3166_mCV->uri;
	Carp::croak("ERROR: Not enough URIs for CV $ISO3166Name")  unless(ref($ISO3166_fetchURIs) eq 'ARRAY' && scalar(@{$ISO3166_fetchURIs})>=3);
	
	# And let's get the output CV file
	my $outputFile = $ISO3166_mCV->localFilename;
	Carp::croak("ERROR: Unable to find path for CV $ISO3166Name")  unless(defined($outputFile));

	my $cldrXMLFile;
	my $iso3166_1_file;
	my $iso3166_2_file;
	
	my $cldrXMLlocalFile;
	my $iso3166_1_localfile;
	my $iso3166_2_localfile;
	
	# Now, let's create a temp directory where to fetch the files needed to rebuild the CVs
	my $tmpworkdir = File::Temp->newdir();
	my $tmpworkdirname = $tmpworkdir->dirname;
	
	foreach my $fetchURI (@{$ISO3166_fetchURIs}) {
		if(defined($fetchURI->format)) {
			if($fetchURI->format eq 'ISO_3166-1') {
				$iso3166_1_localfile = $fetchURI->mirrorURI($tmpworkdirname);
				$iso3166_1_file = $fetchURI->uri;
			} elsif($fetchURI->format eq 'ISO_3166-2') {
				$iso3166_2_localfile = $fetchURI->mirrorURI($tmpworkdirname);
				$iso3166_2_file = $fetchURI->uri;
			} elsif($fetchURI->format eq 'LDML') {
				$cldrXMLlocalFile = $fetchURI->mirrorURI($tmpworkdirname);
				$cldrXMLFile = $fetchURI->uri;
			}
		}
	}
	
	Carp::croak("ERROR: CLDR supplemental data URI unavailable for CV $ISO3166Name")  unless(defined($cldrXMLFile));
	Carp::croak("ERROR: ISO-3166-1 data URI unavailable for CV $ISO3166Name")  unless(defined($iso3166_1_file));
	Carp::croak("ERROR: ISO-3166-2 data URI unavailable for CV $ISO3166Name")  unless(defined($iso3166_2_file));
	
	my $ISO3166CV = BP::Model::CV->new();
	my $ver = exists($ISO3166_mCV->annotations->hash->{'data-version'})?$ISO3166_mCV->annotations->hash->{'data-version'}:undef;
	$ISO3166CV->annotations->addAnnotation('data-version',$ver)  if(defined($ver));
	
	print "Step 1: parsing $cldrXMLFile\n";
	my $CLDR = XML::LibXML->load_xml(location => $cldrXMLlocalFile);
	
	# Let's record what we are not interested in, so we can filter it out later
	my %filt=();
	foreach my $territoryCode  ($CLDR->getElementsByTagName('territoryCodes')) {
		unless($territoryCode->hasAttribute('numeric')) {
			$filt{$territoryCode->getAttribute('type')} = undef;
		}
	}
	
	# Let's get what we are interested in, the supranational organizations
	foreach my $territoryContainment  ($CLDR->getElementsByTagName('territoryContainment')) {
		my $type = undef;
		my @contains = ();
		my $status = undef;
		my $isGrouping = undef;
		foreach my $group ($territoryContainment->childNodes()) {
			if($group->nodeType eq XML::LibXML::XML_ELEMENT_NODE && $group->localname eq 'group') {
				$status = $group->hasAttribute('status')?$group->getAttribute('status'):undef;
				# Skipping deprecated regions
				next  if(defined($status) && $status eq 'deprecated');

				$type = $group->getAttribute('type');
				@contains = ();
				
				foreach my $component  (split(/ /,$group->getAttribute('contains'))) {
					push(@contains,$component)  unless(exists($filt{$component}));
				}
				$isGrouping = ($group->hasAttribute('grouping') && $group->getAttribute('grouping') eq 'true')?1:undef;
			} elsif($group->nodeType eq XML::LibXML::XML_COMMENT_NODE) {
				my $name = $group->nodeValue;
				
				if(defined($type)) {
					# Defining supranational entities as aliases
					if($ISO3166CV->isValid($type)) {
						my $term = $ISO3166CV->CV->{$type};
						push(@{$term->parents},@contains);
					} else {
						$ISO3166CV->addTerm(BP::Model::CV::Term->new($type,$name,undef,[@contains],1));
					}
					
					$type = undef;
				}
			}
		}
	}
	
	# Now, let's go for the countries!
	print "Step 2: parsing $iso3166_1_file\n";
	my $ISO1 = XML::LibXML->load_xml(location => $iso3166_1_localfile);
	foreach my $country ($ISO1->getElementsByTagName('iso_3166_entry')) {
		my @keys = ($country->getAttribute('alpha_2_code'),$country->getAttribute('alpha_3_code'),$country->getAttribute('numeric_code'));
		my $name = $country->getAttribute('name');
		$ISO3166CV->addTerm(BP::Model::CV::Term->new(\@keys,$name));
	}
	
	# And at last, the provinces and so
	print "Step 3: parsing $iso3166_2_file\n";
	my $ISO2 = XML::LibXML->load_xml(location => $iso3166_2_localfile);
	foreach my $country ($ISO2->getElementsByTagName('iso_3166_country')) {
		my $code = $country->getAttribute('code');
		
		foreach my $subset ($country->getElementsByTagName('iso_3166_subset')) {
			foreach my $entry ($subset->getElementsByTagName('iso_3166_2_entry')) {
				my $entryCode = $entry->getAttribute('code');
				my $parentCode = $entry->hasAttribute('parent')?($code.'-'.$entry->getAttribute('parent')):$code;
				my $name = $entry->getAttribute('name');
				$ISO3166CV->addTerm(BP::Model::CV::Term->new($entryCode,$name,undef,[$parentCode]));
			}
		}
	}
	
	$ISO3166CV->validateAndEnactAncestors(1);
	
	print "Writing to $outputFile\n";
	my $comments = <<CEOF;
Generated using $0 from
	$cldrXMLFile
	$iso3166_1_file
	$iso3166_2_file
CEOF
	
	my $tmpOBOISO3166file = File::Spec->catfile($tmpworkdirname,File::Basename::basename($outputFile));
	if(open(my $O,'>:encoding(UTF-8)',$tmpOBOISO3166file)) {
		$ISO3166CV->OBOserialize($O,$comments);
		close($O);
		File::Copy::move($tmpOBOISO3166file,$outputFile);
	} else {
		Carp::croak("Unable to create output file ".$outputFile);
	}
} else {
	# http://unicode.org/repos/cldr/trunk/common/supplemental/supplementalData.xml
	# http://www.commondatahub.com/live/geography/state_province_region/iso_3166_2_state_codes
	# Data is in git://git.debian.org/git/iso-codes/iso-codes.git
	# in paths iso_3166/iso_3166.xml and iso_3166_2/iso_3166_2.xml
	# http://anonscm.debian.org/gitweb/?p=iso-codes/iso-codes.git;a=blob_plain;f=iso_3166/iso_3166.xml;hb=HEAD
	# http://anonscm.debian.org/gitweb/?p=iso-codes/iso-codes.git;a=blob_plain;f=iso_3166_2/iso_3166_2.xml;hb=HEAD
	# https://anonscm.debian.org/cgit/pkg-isocodes/iso-codes.git/plain/iso_3166/iso_3166.xml
	# https://anonscm.debian.org/cgit/pkg-isocodes/iso-codes.git/plain/iso_3166_2/iso_3166_2.xml
	print STDERR <<EOF
ERROR: This program takes two parameters:
	- The BP model (either in XML or BP format)
	- The ISO-3166 CV name in the model
EOF
}
