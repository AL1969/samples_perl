
use File::Spec;

my $curdir = File::Spec->curdir();
print STDERR "curdir=$curdir\n";

my $tmpdir = File::Spec->tmpdir();
print STDERR "tmpdir=$tmpdir\n";

my $rootdir = File::Spec->rootdir();
print STDERR "rootdir=$rootdir\n";

my $updir = File::Spec->updir();
print STDERR "updir=$updir\n";


my $testpath = "D:/users/alang/eCognition/Cases";
my $cpath = File::Spec->canonpath( $testpath ) ;
print STDERR "cpath=$cpath\n";
my $cpath = File::Spec->canonpath( $testpath."/.." ) ;
print STDERR "cpath=$cpath\n";

