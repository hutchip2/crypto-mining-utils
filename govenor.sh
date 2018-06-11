#!/bin/bash

if [ -z "$1" ] || [ -z "$2" ]; then
        echo "Missing required parameter(s): COIN, POOL"
        exit 1
fi

PROCESS=$(cat ./properties.json | jq '.coin.'$1'.process' | sed -e 's/^"//' -e 's/"$//')
EXECUTE='screen -d -m ./coin/'$1'/'$process' '$2

if [ pgrep $PROCESS > /dev/null 2>&1 ]; then
    exit 0
else
    $EXECUTE
fi

exit 0
