
### save job data to a file
use strict;

# e.g. perl hash_in.pl C:/TEMP/hash

use Storable;
# see http://perldoc.perl.org/Storable.html

my $filepath = $ARGV[0];
print STDERR "read from '$filepath'\n";

my %hash;
my $hashref = retrieve($filepath);

print STDERR "URL: $hashref->{'URL'}\n";
print STDERR "port: $hashref->{'port'}\n";
print STDERR "PID: $hashref->{'PID'}\n";



