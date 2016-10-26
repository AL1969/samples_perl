
use strict;

use LWP::UserAgent;
use HTTP::Request::Common;
use Data::Dumper;

my $code="641dd482f38084f36725fc835b44942";

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

#POST /i/oauth2/token?grant_type=authorization_code&tenantDomain=trimble.com&code=7830dd3126d7276ba652b9a98c615820&redirect_uri=http%3A%2F%2Flocalhost%3A8888%2Fauth_trimbleid%2Foauth_after.html HTTP/1.1
#accept: "application/json"
#authorization: "Basic SEE3NG02UFBZN1NzX19zejBVTVVER2ltTVlZYTpYcFZxQmYyY1kyZ0UwVzdxeUhZOXNPdFBOZmdh"
#cache-control: "no-cache"
#content-type: "application/x-www-form-urlencoded"
#host: "identity-stg.trimble.com"

#my $content = '{ "grant_type": "authorization_code", "code": $code, "redirect_uri": $rediruri, "tenantDomain": "trimble.com"}';
#my $content = '{ "grant_type": "authorization_code" }';

# add POST data to HTTP request body
#my $post_data = '{ "name": "Dan", "address": "NY" }';
#$req->content($content);

my $ua = LWP::UserAgent->new;
my $resp = $ua->request($req);
print Dumper(\%$resp);
#print "Response: $resp\n";
if ($resp->is_success) {
	my $message = $resp->decoded_content;
	print "Received reply: $message\n";
}
else {
	print "HTTP POST error code: ", $resp->code, "\n";
	print "HTTP POST error message: ", $resp->message, "\n";
}

#my $response = (new LWP::UserAgent)->request(POST $server_endpoint,
#	[ grant_type    => "authorization_code",
#	  code          => $code,
#	  redirect_uri  => $redirurienc,
#	  tenantDomain  => "trimble.com" ] );

#xit -1 unless $response->is_success;
#$_ = $response->{_content};
#print $_;


