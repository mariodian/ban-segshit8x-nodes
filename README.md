# ban-segshit8x-nodes

## Prerequisites
Your bitcoind daemon must be running (running just the Bitcoin Core gui is not enough).

## Linux
The ban.sh script will ban all fake SegShit8x nodes. The list of nodes is obtained from bitnodes.21.co.

### Requirements for the bash script (ban.sh)
Command-line JSON processor `jq`.

#### Install on Debian-based Linux
````
sudo apt-get install jq
````

#### Install on OSX
````
brew install jq
````

### Requirements for the perl script (ban.pl)
Perl & Perl packages `JSON::XS` and `LWP::UserAgent`.

#### Install on Debian-based Linux
````
sudo apt-get install libjson-xs-perl
````

#### CPAN
````
sudo cpan -i JSON::XS
````

### Download and use the script
````
git clone https://github.com/mariodian/ban-segshit8x-nodes.git
cd ban-segshit8x-nodes
chmod u+x ban.sh ban.pl
````

#### Run the bash script
````
./ban.sh
````

#### Run the perl script
````
perl ./ban.pl
````

## Windows
The ban.ps1 powershell script is a port of the ban.sh script.  Accomplishes the same thing on Windows.

It _might_ work in Powershell 2.0, but you should really have PS 3.0 or greater.

If you've never used Powershell before, you might need to enable script execution.  See the instructions here:  https://superuser.com/questions/106360/how-to-enable-execution-of-powershell-scripts

### Run the ban script
Open a Powershell prompt in the script directory and simply type "./ban".  
