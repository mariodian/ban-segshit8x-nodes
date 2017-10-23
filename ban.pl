#!/usr/bin/perl
#NO2XNO2XNO2XNO2XNO2XNO2XNO2XNO2XNO2XNO2XNO2XNO2XNO2XNO2XNO2XNO2XNO2XNO2X#
#
# This is basically a perl version of @mariodian's ban-segshit8x-nodes
# It works for both IPv4 & IPv6-addresses. If you want to ban BitcoinABC, 
# BUCash and Bitcoin Unlimited nodes, see regex below.
# If you like it, drop me a tweet :-)
#
# Requirements: Perl & Perl packages JSON::XS and LWP::UserAgent.
# These can be installed through your package manager like this;
#     sudo apt-get install libjson-xs-perl
# or with cpan, like this;
#     sudo cpan -i JSON::XS
# The script needs to be run from bitcoin-cli folder, or you need bitcoin-cli in your path.
#
# Author: @herrpuppekanin
# BTC: 3Qe5JQBBXWQP6XKRJNpmBrgnNoRqNnfcke
#
#NO2XNO2XNO2XNO2XNO2XNO2XNO2XNO2XNO2XNO2XNO2XNO2XNO2XNO2XNO2XNO2XNO2XNO2X#

use strict;
use warnings;
use JSON::XS qw( decode_json );
use LWP::UserAgent;

my $BAN_TIME=5184000;

my $ua = LWP::UserAgent->new();
$ua->agent("Mozilla/8.0");
my $server_endpoint="https://bitnodes.21.co/api/v1/snapshots/?page=1";
my $snapshots = call($server_endpoint);
my $latest_snapshot_url = $snapshots->{results}[0]->{url};
my $network_connected_nodes = call($latest_snapshot_url);
my $nodes = $network_connected_nodes->{nodes};
my @node_keys = keys %{$nodes};

foreach my $node (@node_keys) {
  my $node_ip = substr($node, 0, index($node, ':'));
  #If this was an IPv6 node, get the ipv6-address.
  if(length($node_ip) == 5) {
    $node_ip = substr($node,1,index($node,']')-1);
  }
  my @node_data = @{$nodes->{$node}};
  my $node_version = $node_data[1];
  ### If you wish to also ban BCash and Bitcoin Unlimited nodes, add |ABC|BUCash|Unlimited to the regex
  if($node_version =~ /Satoshi:1.1|\(2x|YES2X/) {
    ### If bitcoin-cli is not in your PATH, add its full path below, such as /usr/local/bitcoin/bin/bitcoin-cli or C:\whatever\whatever\bitcoin-cli
    `bitcoin-cli setban $node_ip "add" $BAN_TIME`;
    print("Found and banned shit node: " . $node_ip . " version; " . $node_version . "\n");
  }
}

exit 0;

sub call {
  my ($endpoint) = @_;
  my $message;
  my $req = HTTP::Request->new(GET => $endpoint);
  my $resp = $ua->request($req);
  if ($resp->is_success) {
    $message = $resp->decoded_content;
  }
  else {
    print "HTTP GET error code: ", $resp->code, "\n";
    print "HTTP GET error message: ", $resp->message, "\n";
    my %error_hash = ('response-code' => $resp->code, 'response-message' => $resp->message);
    print("Couldn't get data from bitnodes.21.co, error code: $resp->code, error message: $resp->message \n");
    exit;
  }
  return decode_json $message;
}
