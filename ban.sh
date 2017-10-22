#!/bin/bash

command -v jq >/dev/null 2>&1 || { echo >&2 "Please install \"jq\" first. Aborting."; exit 1; }

NODES_FILE='/tmp/segshit-nodes.txt'
BAN_TIME="5184000"

# Download the latest nodes snapshot
SNAPSHOT=`wget -qO- https://bitnodes.21.co/api/v1/snapshots/ | jq '.results[0] | .url'`

# Download the list of currently connected nodes
wget ${SNAPSHOT//\"} -O $NODES_FILE

NODES=$(cat $NODES_FILE | jq -r -c '.nodes | to_entries | map([.key + .value[1]]) | .[]')
COUNT=0

for NODE in ${NODES[@]}; do
  # Find all/most SegShit nodes
  if [[ $NODE == *"Satoshi:1.1"* || $NODE == *"(2x"* ]]; then
    IP=$(echo $NODE | egrep -o '([0-9]{1,3}\.){3}[0-9]{1,3}:[0-9]{4,5}')
    NAME=$(echo $NODE | egrep -o '\/.*\/')

    # IP exists
    if [[ ! -z $IP ]]; then
      # Ban node
      $(bitcoin-cli setban ${IP%:*} "add" ${BAN_TIME})

      echo "Found and banned SegShit8x node: $IP"

      ((COUNT++))
    fi
  fi
done

echo Found and banned $COUNT nodes.

rm $NODES_FILE
