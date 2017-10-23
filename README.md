# ban-segshit8x-nodes
This script will ban all fake SegShit8x nodes. The list of nodes is obtained from bitnodes.21.co.

## Requirements for the bash script
Command-line JSON processor `jq`.

### Debian-based Linux
````
sudo apt-get install jq
````

### OSX
````
brew install jq
````

## Requirements for the perl script
Perl & Perl packages `JSON::XS` and `LWP::UserAgent`.

### Debian-based Linux
````
sudo apt-get install libjson-xs-perl
````

### CPAN
````
sudo cpan -i JSON::XS
````

## Install and use the script
````
git clone https://github.com/mariodian/ban-segshit8x-nodes.git
cd ban-segshit8x-nodes
chmod u+x ban.sh ban.pl
````

### Run the bash script
````
./ban.sh
````

### Run the perl script
````
perl ./ban.pl
````
