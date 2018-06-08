#!/bin/bash

export GPU_FORCE_64BIT_PTR=0
export GPU_USE_SYNC_OBJECTS=1
export GPU_MAX_HEAP_SIZE=100
export GPU_MAX_ALLOC_PERCENT=100
export GPU_SINGLE_ALLOC_PERCENT=100

cd /path/to/claymore

./ethdcrminer64 -epool stratum+tcp://us1.ethermine.org:4444 -ewal YOUR_WALLET_HERE -eworker YOUR_MINER_ID_HERE -epsw x -mode 1 -tt 80 -allpools 1

exit 0
