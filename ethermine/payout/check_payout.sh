#!/bin/bash

amt=$(python /path/to/check_payout.py 2>&1)
if [[ $amt != "" ]]; then
        python /path/to/notify.py "YOUR_MINER_ID" "PAYOUT ${amt} ETH" > /dev/null
fi
exit 0
