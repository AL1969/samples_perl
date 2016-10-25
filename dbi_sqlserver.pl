
### something about DBI in Perl
### AL 2012-02-08
### used Perl PPM for installing the SQLite package DBD-SQLite 1.35
### > ppm

use strict;
use DBI;

my @dbi_drivers = DBI->available_drivers;
print "List of drivers: @dbi_drivers\n";

# my $db_instance = "localhost\\SQLEXPRESS";
# my $db_name = "myDatabase";
# my $db_user = "myUser";
# my $db_pass = "";
# my $dbh = DBI->connect("DBI:ODBC:Driver={SQL Server};Server=$db_instance;Database=$db_name;UID=$db_user;PWD=$db_pass") or die("\n\nCONNECT ERROR:\n\n$DBI::errstr");

#my $dbh = DBI->connect("dbi:ODBC:Driver={SQL Server};Server=dem-eu-app-13\\SQLEXPRESS;Database=fnxprod;UID=fnxprod;PWD=fnxprod");
#my $dbh = DBI->connect("dbi:ODBC:Driver={SQL Server};Server=10.2.200.63\\SQLEXPRESS;Database=fnxprod;UID=fnxprod;PWD=fnxprod");
my $dbh = DBI->connect('dbi:ODBC:DSN=fnotest', 'fnxprod', 'fnxprod');

my ($actid) = "";
my $res = $dbh->selectall_arrayref("select act.ACTIVATION_ID activation_id
from dbo.OPS_ENTITLEMENT_ORDER ent
join dbo.OPS_ACTIVATABLE_ITEM act on act.PARENT_ENTITLEMENT_ID = ent.id
where ent.ENTITLEMENT_ID='mnhtpa02loskfjjlrts0'");
foreach my $row (@$res) {
	($actid) = @$row;
	print("actid=$actid\n");
}

$dbh->disconnect();
