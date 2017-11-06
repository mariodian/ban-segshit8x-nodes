# helper to turn PSCustomObject into a list of key/value pairs
function Get-ObjectMembers {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$True, ValueFromPipeline=$True)]
        [PSCustomObject]$obj
    )
    $obj | Get-Member -MemberType NoteProperty | ForEach-Object {
        $key = $_.Name
        [PSCustomObject]@{Key = $key; Value = $obj."$key"}
    }
}

# Script starts here.
$BAN_TIME = 5184000;

# Find install location of bitcoin binaries
$REG_KEY_PATH = "REGISTRY::HKEY_CURRENT_USER\Software\Bitcoin Core (64-bit)"

$regKey = Get-ItemProperty -Path $REG_KEY_PATH
$bitcoinInstallDirectory = $regKey.Path
$bitcoinCliPath = Join-Path $bitcoinInstallDirectory "\daemon\bitcoin-cli.exe"

if (-not (Test-Path $bitcoinCliPath)) {
    throw "Unable to find bitcoin installation directory"
}


# Download the latest nodes snapshot
$request = "https://bitnodes.21.co/api/v1/snapshots";

$firstSnapshotUrl = Invoke-WebRequest $request |
                    ConvertFrom-Json  |
                    select -expand results  | 
                    select url -First 1         # Select the first snapshot.
       

$COUNT=0

Invoke-WebRequest $firstSnapshotUrl.url |       # Download the snapshot JSON
ConvertFrom-Json |
select -expand nodes |                          # Iterate each node
Get-ObjectMembers  | 
    foreach {
     if ($_.Value[1] -like '*Satoshi:1.1*' -or $_.Value[1] -like '*(2x*') {
         $IP = $_.Key;
         $IP = $IP -replace ":\d{1,5}$"     #Strip port number off the end

         Write-Host "Banning $IP due to agent " $_.Value[1]
         
         # Call into bitcoin-cli and ban.
         $AllArgs = @('setban', $IP, 'add', $BAN_TIME)
         & $bitcoinCliPath $AllArgs
         
         $COUNT = $COUNT + 1
     } 
}

Write-Host "Found and banned $COUNT nodes.";



