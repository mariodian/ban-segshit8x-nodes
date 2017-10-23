# ban-segshit8x-nodes
This script will ban all fake SegShit8x nodes. The list of nodes is obtained from bitnodes.21.co.

## Requirements for the bash script
Command-line JSON processor `jq`.

### Install on Debian-based Linux
````
sudo apt-get install jq
````

### Install on OSX
````
brew install jq
````

## Requirements for the perl script
Perl & Perl packages `JSON::XS` and `LWP::UserAgent`.

### Install on Debian-based Linux
````
sudo apt-get install libjson-xs-perl
````

### CPAN
````
sudo cpan -i JSON::XS
````

## Download and use the script
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
