# ban-segshit8x-nodes

## Prerequisites
Your bitcoind daemon must be running (running just the Bitcoin Core gui is not enough).

Download the script:

`git clone https://github.com/mariodian/ban-segshit8x-nodes.git`


## Linux
The ban.sh script will ban all fake SegShit8x nodes. The list of nodes is obtained from bitnodes.21.co.

You need `jq` to parse the json.

Run:

````
cd ban-segshit8x-nodes   
chmod u+x ban.sh   
./ban.sh
````

## Windows
The ban.ps1 powershell script is a port of the ban.sh script.  Accomplishes the same thing on Windows.

It _might_ work in Powershell 2.0, but you should really have PS 3.0 or greater.

If you've never used Powershell before, you might need to enable script execution.  See the instructions here:  https://superuser.com/questions/106360/how-to-enable-execution-of-powershell-scripts

#### To run the ban script:
Open a Powershell prompt in the script directory and simply type "./ban".  