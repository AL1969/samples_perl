
use strict;

use LWP::UserAgent;

my $code="83117d2688add27ec5b3a614c31c31";


my $ua = LWP::UserAgent->new;

my $server_endpoint = "https://identity-stg.trimble.com/i/oauth2/token";

my $rediruri="http://localhost:8888/auth_trimbleid/oauth_after.html";
my $authstr="Basic SEE3NG02UFBZN1NzX19zejBVTVVER2ltTVlZYTpYcFZxQmYyY1kyZ0UwVzdxeUhZOXNPdFBOZmdh";

my $req = HTTP::Request->new(POST => $server_endpoint);
$req->header("Authorization" => $authstr);
$req->header('Content-Type' => 'application/x-www-form-urlencoded');
$req->header('Accept' => 'application/json');
$req->header('Cache-Control' => 'no-cache');

#my $contentstr = "grant_type=authorization_code&code=" . $code . "&redirect_uri=" . $rediruri . "&tenantDomain=trimble.com";
#print "contentstr=$contentstr";

my $content = '{ "grant_type": "authorization_code", "code": $code, "redirect_uri": $rediruri, "tenantDomain": "trimble.com"}';
#my $content = '{ "grant_type": "authorization_code" }';
print "content=$content";

# add POST data to HTTP request body
#my $post_data = '{ "name": "Dan", "address": "NY" }';
$req->content($content);

my $resp = $ua->request($req);
if ($resp->is_success) {
	my $message = $resp->decoded_content;
	print "Received reply: $message\n";
}
else {
	print "HTTP POST error code: ", $resp->code, "\n";
	print "HTTP POST error message: ", $resp->message, "\n";
}


#my $rediruri="http%3A%2F%2Flocalhost%3A8888%2Fauth_trimbleid%2Foauth_after.html";

#rem curl -v -k -X POST -H "Content-Type: application/x-www-form-urlencoded" -H "Authorization: Basic %authstr%" -H "Accept: application/json" -H "Cache-Control: no-cache" "https://identity-stg.trimble.com/i/oauth2/token?grant_type=authorization_code&tenantDomain=trimble.com&code=%code%&redirect_uri=%rediruri%"

#curl -k -X POST -H "Host: identity-stg.trimble.com" -H "Authorization: Basic %authstr%" -H "Content-Type: application/x-www-form-urlencoded; charset=UTF-8" -H "Accept: application/json" -H "Cache-Control: no-cache" --data "grant_type=authorization_code" --data "code=%code%" --data "redirect_uri=%rediruri%" --data "tenantDomain=trimble.com" https://identity-stg.trimble.com/i/oauth2/token --trace-ascii xcurl_trace.txt

