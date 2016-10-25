
print STDOUT "Perl pattern matching tests:\n";

my @checkstrs = ("Test", "ESt", "C:\\temp\\pretty PATH\\hello.exp", "C:/temp/pretty PATH/world.lib", "C:/temp/pretty PATH/valid.dll");

print STDOUT "CHECK several strings for matching being not .lib or .exp\n";
# http://stackoverflow.com/questions/20229880/perl-regex-negation
foreach my $checkstr (@checkstrs) {
	if ($checkstr =~ /^(?!.*(?:\.lib|\.exp))/) {
		print STDOUT "  String match '$checkstr' ==> YES\n";
	}
	else {
		print STDOUT "  String match '$checkstr' ==> no\n";
	}
}
