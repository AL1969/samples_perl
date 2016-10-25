
### something about DBI in Perl
### AL 2012-02-08
### used Perl PPM for installing the SQLite package DBD-SQLite 1.35
### > ppm

use strict;
use DBI;
use File::Copy;

#my $dbpath = "//dem-eu-app-13/Build/TestInput/TaskMain/tmp_dpj_sqlite/GEO - No_Data-Intersection/GEO - No_Data-Intersection.dpj";
#my $dbpath = "//dem-eu-app-13/Build/TestInput/TaskMain/tmp_dpj_sqlite/RsterFrmtImprt_Metadata/RsterFrmtImprt_Metadata.dpj";
#my $dbpath = "//dem-eu-app-13/Build/TestInput/TaskMain/tmp_dpj_sqlite/RsterFrmtImprt_UserCoord/RsterFrmtImprt_UserCoord.dpj";
my $dbpath = "//dem-eu-app-13/Build/TestInput/TaskMain/IntegrationTest/CoordCheck/CoordCheck_test.dpj";
#E:\TestInput\TaskMain\IntegrationTest\CoordCheck
#"\\dem-eu-app-13\Build\TestInput\TaskMain\IntegrationTest"


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


# BEFORE
# id=1 filepath='\\icox64\TestInput\IntegrationTest\CoordCheck\geographic_coord.dcp'
# id=2 filepath='\\icox64\TestInput\IntegrationTest\CoordCheck\wsiearth.tif'
# id=3 filepath='\\icox64\TestInput\IntegrationTest\CoordCheck\wsiearth.tif'
# id=4 filepath='\\icox64\TestInput\IntegrationTest\CoordCheck\wsiearth.tif'
# id=5 filepath='dpr\.v1.dpr'
# AFTER
# id=1 filepath='\\dem-eu-app-13\Build\TestInput\IntegrationTest\CoordCheck\geographic_coord.dcp'
# id=2 filepath='\\dem-eu-app-13\Build\TestInput\IntegrationTest\CoordCheck\wsiearth.tif'
# id=3 filepath='\\dem-eu-app-13\Build\TestInput\IntegrationTest\CoordCheck\wsiearth.tif'
# id=4 filepath='\\dem-eu-app-13\Build\TestInput\IntegrationTest\CoordCheck\wsiearth.tif'
# id=5 filepath='dpr\.v1.dpr'
# E:\TestInput\TaskMain\IntegrationTest\CoordCheck

# '\\icox64\TestInput\IntegrationTest\CoordCheck\geographic_coord.dcp'
# to
# '\\dem-eu-app-13\Build\TestInput\TaskMain\IntegrationTest\CoordCheck\geographic_coord.dcp'

# UPDATE
my $str = "";
#my $rep_from = '\\\\icox64\\TestInput';
#my $rep_to = '\\\\hellosrv\\TestInput';
#my $rep_from = 'icox64';
#my $rep_to = 'dem-eu-app-13\Build';
my $rep_from = 'icox64\TestInput';
my $rep_to = 'dem-eu-app-13\Build\TestInput\TaskMain';
foreach $id (keys %pathsToID) {
	$str = $pathsToID{$id};
	#print STDOUT "before: '$str'\n";
	#$str =~ s/$rep_from/$rep_to/i;
	$str =~ s/\Q$rep_from\E/$rep_to/i;
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
