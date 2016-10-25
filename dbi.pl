
### something about DBI in Perl
### AL 2012-02-08
### used Perl PPM for installing the SQLite package DBD-SQLite 1.35
### > ppm

use strict;
use DBI;

my @dbi_drivers = DBI->available_drivers;
print "List of drivers: @dbi_drivers\n";

### Doc: file:///C:/Perl/html/site/lib/DBD/SQLite.html
### HowTo's:
### http://wiki.magenbrot.net/programmierung/perl/perl_und_sqlite
### http://souptonuts.sourceforge.net/readme_sqlite_tutorial.html
my $dbargs = {AutoCommit => 1, PrintError => 1};
my $dbpath = "D:/tmp/CoordCheck/CoordCheck.dpj";
my $dbh = DBI->connect("dbi:SQLite:dbname=$dbpath", "", "", $dbargs);

# # eine Zeile einfuegen
# $dbh->do("INSERT INTO status (name, age) VALUES ('Michael Mustermann', '25');");
# if ($dbh->err()) { die "$DBI::errstr\n"; }
# $dbh->commit();

# # Zeilen ausgeben
# my ($name, $age) = "";
# my $res = $dbh->selectall_arrayref("SELECT name, age FROM status;");
# foreach my $row (@$res) {
  # ($name, $age) = @$row;
    # print("Name: $name - Alter: $age\n");
# }

my ($id, $filepath) = "";
my $res = $dbh->selectall_arrayref("SELECT id, filepath FROM diat_extrn_files;");
foreach my $row (@$res) {
	($id, $filepath) = @$row;
	print("id=$id filepath='$filepath'\n");
}

if ($dbh->err()) { die "$DBI::errstr\n"; }
$dbh->disconnect();
