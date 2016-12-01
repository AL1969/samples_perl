
### Testing Trimble Connect
# * Auth
# * list projects
# * List Items in a Folder (using project ID)
# * Download an item

use strict;

use LWP::UserAgent;
use HTTP::Request::Common;
use Data::Dumper;
use JSON;

# using JSON package
# see http://xmodulo.com/how-to-parse-json-string-in-perl.html
# and https://www.tutorialspoint.com/json/json_perl_example.htm

our $gTCRootUrl = "https://staging.qa1.gteam.com/tc/api/2.0";
our $gIdToken = "";

if (defined $ENV{'ID_TOKEN'}) {
	$gIdToken = $ENV{'ID_TOKEN'};
}
else {
	print stderr "ERROR: environment variable ID_TOKEN not found\n";
	exit 1;
}

# get token
sub get_token {
	my $token = "";
	my $getTokenUrl = $gTCRootUrl . "/auth/token";
	print "getTokenUrl=$getTokenUrl\n";

	my %rec_hash = ('jwt' => $gIdToken);
	my $json = encode_json \%rec_hash;		
	#print "json=$json\n";
	
	my $req = HTTP::Request->new(POST => $getTokenUrl);
	$req->header('Content-Type' => 'application/json');
	$req->content($json);

	my $ua = LWP::UserAgent->new;
	my $resp = $ua->request($req);
	#print Dumper(\%$resp);
	my $json_string = "";
	if ($resp->is_success) {
		my $message = $resp->decoded_content;
		print "Received reply: $message\n";
		$json_string = $message;
	}
	else {
		print "HTTP POST error code: ", $resp->code, "\n";
		print "HTTP POST error message: ", $resp->message, "\n";
		return "";
	}

	my $json_data = decode_json($json_string);
	#print Dumper $json_data;

	$token = $json_data->{'token'};
	print " ==> token='$token'\n";
	
	return $token;
}

# list the projects
sub list_projects {
	my $headerAuthStr = shift;

	my $getProjectListUrl = $gTCRootUrl . "/projects";
	print "getProjectListUrl=$getProjectListUrl\n";

	my $req = HTTP::Request->new(GET => $getProjectListUrl);
	$req->header("Authorization" => $headerAuthStr);
	$req->header('Content-Type' => 'application/json');

	my $ua = LWP::UserAgent->new;
	my $resp = $ua->request($req);
	print Dumper(\%$resp);
}

# get token for the action
my $token = get_token();

if ($token eq "") {
	print stderr "ERROR: could not receive a token - ID_TOKEN expired?\n";
	exit 1;
}

# list projects using authentication with the received token
my $headerAuthStr="Bearer $token";
list_projects($headerAuthStr);

exit 0;


