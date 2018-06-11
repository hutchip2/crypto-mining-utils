#!/bin/bash

if [ -z "$1" ] || [ -z "$2" ]; then
        echo "Missing required parameter(s): COIN, POOL"
        exit 1
fi

if [ pgrep 'mine.sh' > /dev/null 2>&1 ]; then
    exit 0
else
    export GPU_FORCE_64BIT_PTR=0
    export GPU_USE_SYNC_OBJECTS=1
    export GPU_MAX_HEAP_SIZE=100
    export GPU_MAX_ALLOC_PERCENT=100
    export GPU_SINGLE_ALLOC_PERCENT=100

    MINER=$(cat ./properties.json | jq -r '.coin.'$1'.miner')
    PARAMS=$(cat ./properties.json | jq -r '.miner.'$MINER'.params')

    PARAMS=${PARAMS//POOL/$(cat ./properties.json | jq -r '.coin.'$1'.pool.'$2'.url')}
    PARAMS=${PARAMS//PORT/$(cat ./properties.json | jq -r '.coin.'$1'.pool.'$2'.port')}
    PARAMS=${PARAMS//PASSWORD/$(cat ./properties.json | jq -r '.coin.'$1'.pool.'$2'.password')}
    PARAMS=${PARAMS//WALLET/$(cat ./properties.json | jq -r '.coin.'$1'.wallet')}
    PARAMS=${PARAMS//WORKER/$(cat ./properties.json | jq -r '.worker')}
    PARAMS=${PARAMS//HTTPD/$(cat ./properties.json | jq -r '.miner.'$MINER'.httpd')}
    PARAMS=${PARAMS//CURRENCY/$(cat ./properties.json | jq -r '.miner.'$MINER'.currency')}
    PATH=$(cat ./properties.json | jq -r '.miner.'$MINER'.path')

    /usr/bin/screen -d -m $PATH $PARAMS
fi

exit 0
