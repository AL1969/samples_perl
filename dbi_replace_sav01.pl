
### something about DBI in Perl
### AL 2012-02-08
### used Perl PPM for installing the SQLite package DBD-SQLite 1.35
### > ppm

use strict;
use DBI;
use File::Copy;

my $dborigpath = "D:/tmp/CoordCheck/CoordCheck_bak.dpj";
my $dbpath = "D:/tmp/CoordCheck/CoordCheck.dpj";
copy($dborigpath, $dbpath);

#my @dbi_drivers = DBI->available_drivers;
#print "List of drivers: @dbi_drivers\n";

### Doc: file:///C:/Perl/html/site/lib/DBD/SQLite.html
### HowTo's:
### http://wiki.magenbrot.net/programmierung/perl/perl_und_sqlite
### http://souptonuts.sourceforge.net/readme_sqlite_tutorial.html
my $dbargs = {AutoCommit => 1, PrintError => 1};
my $dbh = DBI->connect("dbi:SQLite:dbname=$dbpath", "", "", $dbargs);

print "BEFORE\n";
my ($id, $filepath) = "";
my $res = $dbh->selectall_arrayref("SELECT id, filepath FROM diat_extrn_files;");
foreach my $row (@$res) {
	($id, $filepath) = @$row;
	print("id=$id filepath='$filepath'\n");
}

### PROCESSING
# SELECT
my %pathsToID = ();
($id, $filepath) = "";
my $res = $dbh->selectall_arrayref("SELECT id, filepath FROM diat_extrn_files;");
foreach my $row (@$res) {
	($id, $filepath) = @$row;
	$pathsToID{$id} = $filepath;
}
# UPDATE
my $str = "";
#my $rep_from = '\\\\icox64\\TestInput';
#my $rep_to = '\\\\hellosrv\\TestInput';
my $rep_from = 'icox64';
my $rep_to = 'hellosrv';
foreach $id (keys %pathsToID) {
	$str = $pathsToID{$id};
	#print STDOUT "before: '$str'\n";
	$str =~ s/$rep_from/$rep_to/;
	#print STDOUT "after: '$str'\n";
	$dbh->do("UPDATE diat_extrn_files SET filepath='$str' WHERE id=$id;");
	if ($dbh->err()) { die "$DBI::errstr\n"; }
	# no commit because autocommit on
	#$dbh->commit();
}

print "AFTER\n";
($id, $filepath) = "";
my $res = $dbh->selectall_arrayref("SELECT id, filepath FROM diat_extrn_files;");
foreach my $row (@$res) {
	($id, $filepath) = @$row;
	print("id=$id filepath='$filepath'\n");
}

if ($dbh->err()) { die "$DBI::errstr\n"; }
$dbh->disconnect();
