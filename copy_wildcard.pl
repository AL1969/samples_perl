
use strict;

use File::Path;
use File::Copy;
use File::Copy::Recursive;

my $src_dir = "D:/develop/eCog/dev/main/DIS/testlist";
my $dest_dir = "D:/develop/tmp/testlist";

#copy("$src_dir/*.*", $dest_dir);
File::Copy::Recursive::rcopy_glob("$src_dir/*.*", $dest_dir);
