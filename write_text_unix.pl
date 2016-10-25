
# see http://www.perlmonks.org/?node_id=557250

my $outpath="./unixfile.txt";

print STDOUT "write a text file with Unix EOL ($outpath)\n";

my $outfh;
if (!open($outfh, '>', $outpath)) {
	print STDERR "opening file $outpath failed\n";
	exit 1;
};
#my $EOL = "\r\n"; # windows
my $EOL = "\n"; # unix !
binmode($outfh);
print $outfh "Hello$EOL";
print $outfh "Unix$EOL";
print $outfh "World$EOL";
print $outfh "Here I am !$EOL";
close $outfh;

print STDOUT "Finished.";
