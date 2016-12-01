
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

### THIS CODE CAN ONLY BE USED ONCE!
#my $code="21237dee408950628f9d19a70c728fc";

my $tcRootUrl = "https://staging.qa1.gteam.com/tc/api/2.0";
my $id_token = "";
#my $id_token="eyJhbGcixxxxx";

if (defined $ENV{'ID_TOKEN'}) {
	$id_token = $ENV{'ID_TOKEN'};
}
else {
	print stderr "ERROR: environment variable ID_TOKEN not found\n";
	exit 1;
}


#my $server_endpoint = "https://identity-stg.trimble.com/i/oauth2/token";
my $server_endpoint = $tcRootUrl . "/auth/token";
print "server_endpoint=$server_endpoint\n";

#my $rediruri="http://localhost:8888/auth_trimbleid/oauth_after.html";
#my $redirurienc="http%3A%2F%2Flocalhost%3A8888%2Fauth_trimbleid%2Foauth_after.html";
#my $authstr="Basic SEE3NG02UFBZN1NzX19zejBVTVVER2ltTVlZYTpYcFZxQmYyY1kyZ0UwVzdxeUhZOXNPdFBOZmdh";

#my $contentstr = "grant_type=authorization_code&tenantDomain=trimble.com&code=" . $code . "&redirect_uri=" . $redirurienc;
#my $contentstr = "{ \"jwt\": \"xxxxxxxx.xxxxxxx.xxxxx\" }";
my $contentstr = "{ \"jwt\": \"$id_token\" }";
print "contentstr=$contentstr\n";

my $posturl = $server_endpoint;
print "POST $posturl\n";

my $req = HTTP::Request->new(POST => $posturl);
#$req->header("Authorization" => $authstr);
#$req->header('Content-Type' => 'application/x-www-form-urlencoded');
$req->header('Content-Type' => 'application/json');
#$req->header('Accept' => 'application/json');
#$req->header('Cache-Control' => 'no-cache');
#$req->header('Host' => 'identity-stg.trimble.com');
$req->content($contentstr);

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
}

#my $json_string = join '', <han1>;
my $json_data = decode_json($json_string);
print Dumper $json_data;

#print "token: " . $json_data->{'token'} . "\n";

my $token = $json_data->{'token'};
print "token='$token'\n";

#foreach my $section (@$json_data) {
#	print "section
#    print "token: " . $section->{'token'} . "\n";
#}
my $server_endpoint = $tcRootUrl . "/projects";
print "server_endpoint=$server_endpoint\n";

#my $rediruri="http://localhost:8888/auth_trimbleid/oauth_after.html";
#my $redirurienc="http%3A%2F%2Flocalhost%3A8888%2Fauth_trimbleid%2Foauth_after.html";
my $authstr="Bearer $token";

#my $contentstr = "grant_type=authorization_code&tenantDomain=trimble.com&code=" . $code . "&redirect_uri=" . $redirurienc;
#my $contentstr = "{ \"jwt\": \"xxxxxxxx.xxxxxxx.xxxxx\" }";
#my $contentstr = "{ \"jwt\": \"$id_token\" }";
#print "contentstr=$contentstr\n";

my $posturl = $server_endpoint;
print "POST $posturl\n";

my $req = HTTP::Request->new(GET => $posturl);
$req->header("Authorization" => $authstr);
#$req->header('Content-Type' => 'application/x-www-form-urlencoded');
$req->header('Content-Type' => 'application/json');
#$req->header('Accept' => 'application/json');
#$req->header('Cache-Control' => 'no-cache');
#$req->header('Host' => 'identity-stg.trimble.com');
$req->content($contentstr);

my $ua = LWP::UserAgent->new;
my $resp = $ua->request($req);
print Dumper(\%$resp);
#if ($resp->is_success) {
#	my $message = $resp->decoded_content;
#	print "Received reply: $message\n";
#}
#else {
#	print "HTTP POST error code: ", $resp->code, "\n";
#	print "HTTP POST error message: ", $resp->message, "\n";
#}

exit 0;


