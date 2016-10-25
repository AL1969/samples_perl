
# see http://www.perlmonks.org/?node_id=557250

my $inpath="./unixfile.txt";
my $outpath="./unixfile_replace.txt";

print STDOUT "read a text from $inpath and write file with Unix EOL ($outpath) with replacement\n";

#my $infh;
if (!open(infh, '<', $inpath)) {
	print STDERR "opening infile $inpath failed\n";
	exit 1;
};

my @infiledata = <infh>;
# foreach(@infiledata) {
	# my $line=$_;
	# print STDOUT "$line";
# }
close $infh;

#my $outfh;
if (!open(outfh, '>', $outpath)) {
	print STDERR "opening outfile $outpath failed\n";
	exit 1;
};

my $EOL = "\n"; # unix !
binmode(outfh);

foreach(@infiledata) {
	my $line=$_;
	chomp($line);
	if ($line =~ /I am/) {
		$line="Here we are !";
	}
	#print STDOUT "$line";
	print outfh "$line$EOL";
}

close $outfh;

print STDOUT "Finished.";

