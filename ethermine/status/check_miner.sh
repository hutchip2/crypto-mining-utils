#!/bin/bash

python /path/to/check_miner.py > /dev/null
if [[ $? != 0 ]]; then
        python /path/to/notify/notify.py "YOUR_MINER_ID_HERE" "RESTARTED" > /dev/null
        reboot -f
fi
exit 0
