#!/usr/bin/perl -W

use strict;

use XML::LibXML;
use FindBin;
# With this we will be able to use BP::Model::CV::Term
use lib "$FindBin::Bin/schema+tools/lib";
use BP::Model;

if(scalar(@ARGV)==4 || scalar(@ARGV)==1) {
	my($cldrXMLFile,$iso3166_1_file,$iso3166_2_file) = (
		'http://unicode.org/repos/cldr/trunk/common/supplemental/supplementalData.xml',
		'http://anonscm.debian.org/gitweb/?p=iso-codes/iso-codes.git;a=blob_plain;f=iso_3166/iso_3166.xml;hb=HEAD',
		'http://anonscm.debian.org/gitweb/?p=iso-codes/iso-codes.git;a=blob_plain;f=iso_3166_2/iso_3166_2.xml;hb=HEAD',
	);
	
	my $outputFile = shift(@ARGV);
	($cldrXMLFile,$iso3166_1_file,$iso3166_2_file) = @ARGV  if(scalar(@ARGV)>0);
	
	my $ISO3166CV = BP::Model::CV->new();
	
	print "Step 1: parsing $cldrXMLFile\n";
	my $CLDR = XML::LibXML->load_xml(location => $cldrXMLFile);
	
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
						$ISO3166CV->addTerm(BP::Model::CV::Term->new($type,$name,[@contains],1));
					}
					
					$type = undef;
				}
			}
		}
	}
	
	# Now, let's go for the countries!
	print "Step 2: parsing $iso3166_1_file\n";
	my $ISO1 = XML::LibXML->load_xml(location => $iso3166_1_file);
	foreach my $country ($ISO1->getElementsByTagName('iso_3166_entry')) {
		my @keys = ($country->getAttribute('alpha_2_code'),$country->getAttribute('alpha_3_code'),$country->getAttribute('numeric_code'));
		my $name = $country->getAttribute('name');
		$ISO3166CV->addTerm(BP::Model::CV::Term->new(\@keys,$name));
	}
	
	# And at last, the provinces and so
	print "Step 3: parsing $iso3166_2_file\n";
	my $ISO2 = XML::LibXML->load_xml(location => $iso3166_2_file);
	foreach my $country ($ISO2->getElementsByTagName('iso_3166_country')) {
		my $code = $country->getAttribute('code');
		
		foreach my $subset ($country->getElementsByTagName('iso_3166_subset')) {
			foreach my $entry ($subset->getElementsByTagName('iso_3166_2_entry')) {
				my $entryCode = $entry->getAttribute('code');
				my $parentCode = $entry->hasAttribute('parent')?($code.'-'.$entry->getAttribute('parent')):$code;
				my $name = $entry->getAttribute('name');
				$ISO3166CV->addTerm(BP::Model::CV::Term->new($entryCode,$name,[$parentCode]));
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
	if(open(my $O,'>',$outputFile)) {
		$ISO3166CV->OBOserialize($O,$comments);
		close($O);
	}
} else {
	# http://unicode.org/repos/cldr/trunk/common/supplemental/supplementalData.xml
	# http://www.commondatahub.com/live/geography/state_province_region/iso_3166_2_state_codes
	# Data is in git://git.debian.org/git/iso-codes/iso-codes.git
	# in paths iso_3166/iso_3166.xml and iso_3166_2/iso_3166_2.xml
	# http://anonscm.debian.org/gitweb/?p=iso-codes/iso-codes.git;a=blob_plain;f=iso_3166/iso_3166.xml;hb=HEAD
	# http://anonscm.debian.org/gitweb/?p=iso-codes/iso-codes.git;a=blob_plain;f=iso_3166_2/iso_3166_2.xml;hb=HEAD
	print STDERR <<EOF
ERROR: This program takes one parameter (the output file) and three optional ones, which are:
	- the integration of UN.49 and ISO-3166-1 (supra-national organizative areas)
	- the ISO-3166-1 XML file (countries)
	- the ISO-3166-2 XML file (provinces and so)
EOF
}
