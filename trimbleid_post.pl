
use strict;

use LWP::UserAgent;
use HTTP::Request::Common;
use Data::Dumper;

### THIS CODE CAN ONLY BE USED ONCE!
my $code="21237dee408950628f9d19a70c728fc";

my $server_endpoint = "https://identity-stg.trimble.com/i/oauth2/token";
print "server_endpoint=$server_endpoint\n";

my $rediruri="http://localhost:8888/auth_trimbleid/oauth_after.html";
my $redirurienc="http%3A%2F%2Flocalhost%3A8888%2Fauth_trimbleid%2Foauth_after.html";
my $authstr="Basic SEE3NG02UFBZN1NzX19zejBVTVVER2ltTVlZYTpYcFZxQmYyY1kyZ0UwVzdxeUhZOXNPdFBOZmdh";

my $contentstr = "grant_type=authorization_code&tenantDomain=trimble.com&code=" . $code . "&redirect_uri=" . $redirurienc;
print "contentstr=$contentstr\n";

#my $posturl = $server_endpoint . "?" . $contentstr;
my $posturl = $server_endpoint;
print "POST $posturl\n";

my $req = HTTP::Request->new(POST => $posturl);
$req->header("Authorization" => $authstr);
$req->header('Content-Type' => 'application/x-www-form-urlencoded');
$req->header('Accept' => 'application/json');
$req->header('Cache-Control' => 'no-cache');
$req->header('Host' => 'identity-stg.trimble.com');
#$req->header('Content-Length' => 0);
$req->content($contentstr);
#$req->content(Encode::encode_utf8($contentstr));

my $ua = LWP::UserAgent->new;
my $resp = $ua->request($req);
#print Dumper(\%$resp);
if ($resp->is_success) {
	my $message = $resp->decoded_content;
	print "Received reply: $message\n";
}
else {
	print "HTTP POST error code: ", $resp->code, "\n";
	print "HTTP POST error message: ", $resp->message, "\n";
}

