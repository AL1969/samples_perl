
use strict;
use Log::Log4perl qw(:easy);

# Check config every 10 secs
#Log::Log4perl::init('log4perl_3.conf');
#Log::Log4perl::init('log4perl_3.conf');
Log::Log4perl->easy_init($INFO);


my $logger = Log::Log4perl->get_logger();

$logger->debug('this is a debug message');
$logger->info('this is an info message');
$logger->warn('warn');
$logger->error('error');
$logger->fatal('fatal');

