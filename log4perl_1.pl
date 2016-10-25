
use strict;

use Log::Log4perl qw(:easy);
Log::Log4perl->easy_init($ERROR);

DEBUG "This doesn't go anywhere";
ERROR "This gets logged";

