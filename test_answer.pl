
sub sth_is_on {
	### on is 1 (or something);
	#return 1;
	#return "XXX";
	### off is 0 (or "")
	return 0;
	#return "";
}

sub is_unc {
	return shift =~ /^\/\//;
}

sub check_unc {
	my $teststr = shift;
	my $val = is_unc($teststr);
	if (is_unc($teststr)) {
		print STDERR "'$teststr' is UNC ($val)\n";
	} else {
		print STDERR "'$teststr' is NOT UNC ($val)\n";
	}
}

sub not_check_unc {
	my $teststr = shift;
	my $val = is_unc($teststr);
	if ( !is_unc($teststr) ) {
		print STDERR "(X) '$teststr' is NOT UNC ($val)\n";
	} else {
		print STDERR "(X) '$teststr' is UNC ($val)\n";
	}
}

if ( sth_is_on() ) {
	print STDERR "sth on\n"; 
} else {
	print STDERR "sth off\n"; 
}

if ( !sth_is_on() ) {
	print STDERR "sth off\n"; 
} else {
	print STDERR "sth on\n"; 
}

check_unc("//unc/hello/world");
check_unc("/nounc/hello/world");

not_check_unc("//unc/hello/world");
not_check_unc("/nounc/hello/world");


