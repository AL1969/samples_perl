
use strict;
use warnings;

#use WWW::Mechanize;

use LWP::Simple;

# see http://stackoverflow.com/questions/4669670/how-do-i-download-a-file-using-perl
#my $url = 'http://dem-eu-app-20/cgi-bin/mkpdf.pl/http://dem-eu-app-20/pmwiki.php/?n=ECogDataIO.ECogDataIO&action=publish&ptype=book&format=pdf&PHPSESSID=43a991164a8e742966e3c21b6711392f&wpversion=2002019&email=';
my $url = 'http://dem-eu-app-20/cgi-bin/mkpdf.pl/http://dem-eu-app-20/pmwiki.php/?n=ECogDataIO.ECogDataIO&action=publish&ptype=book&format=pdf&PHPSESSID=43a991164a8e742966e3c21b6711392f&wpversion=2002019&email=';
my $local_file_name = 'ECogDataIO.pdf';

#my $mech = WWW::Mechanize->new;

#$mech->get( $url, ":content_file" => $local_file_name );


#my $url = 'http://marinetraffic2.aegean.gr/ais/getkml.aspx';
#my $file = 'data.kml';

getstore($url, $local_file_name);
