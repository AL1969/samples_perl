
use strict;
use Log::Log4perl;

# Check config every 10 secs
Log::Log4perl::init_and_watch('log4perl_2.conf', 10);

my $logger;
$logger = Log::Log4perl->get_logger('house.bedrm.desk.topdrwr');

$logger->debug('this is a debug message');
$logger->info('this is an info message');
$logger->warn('etc');
$logger->error('..');
$logger->fatal('..');

