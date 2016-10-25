
# See Farid Hajji: Perl S. 68ff
# test replacement of a string
my $str = "xxx";

my $rep_from = "Tom";
my $rep_to = "Jerry";

$str = "XTomXTomXTomX";
print STDOUT "before: '$str'\n";
$str =~ s/$rep_from/$rep_to/;
print STDOUT "after: '$str'\n";

### global
$str = "XTomXTomXTomX";
print STDOUT "before: '$str'\n";
my $rep_from = "Tom";
my $rep_to = "Jerry";
$str =~ s/$rep_from/$rep_to/g;
print STDOUT "after (global): '$str'\n";
