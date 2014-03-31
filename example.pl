#!/usr/bin/perl
use strict;
use warnings;
use Data::Dumper; # debug

use DomRobot::Lite;
# use DomRobot::Lite +trace => 'all';


# skip SSL verification for OT&E
$ENV{PERL_LWP_SSL_VERIFY_HOSTNAME}=0;

#my $addr = "https://api.domrobot.com/xmlrpc/";
my $addr = "https://api.ote.domrobot.com/xmlrpc/"; # OT&E

my $usr = 'your_username';
my $pwd = 'your_password';


my $client = DomRobot::Lite
      -> proxy($addr, cookie_jar => HTTP::Cookies->new(ignore_discard => 1)
	);

my ($response);

$client->lang('de');

$response = $client->login($usr,$pwd);
if ($response->result->{code} == 1000) {
	$response = $client->call('domain.check', {
		domain => ['mydomain.com','mydomain2.net']});
	print Dumper($response->result);

}
else {
	# login failed
	print Dumper($response->result);
}


exit 0;
__END__


