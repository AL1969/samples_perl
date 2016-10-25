
### save job data to a file
use strict;

# e.g. perl hash_out.pl C:/TEMP/hash

use Storable;
# see http://perldoc.perl.org/Storable.html

my %hash = ("URL" => "http://www.ecognition.com",
            "port" => 12345,
			"PID" => 1000);

my $key;
foreach $key (keys %hash) {
	print STDERR "'$key' => '$hash{$key}'\n";
}

my $filepath = $ARGV[0];
store(\%hash, "$filepath");
print STDERR "stored in '$filepath'\n";
