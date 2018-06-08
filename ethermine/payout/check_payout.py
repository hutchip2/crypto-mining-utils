#!/usr/bin/python

import sys
import json
import requests
import datetime

def main():
    r = requests.request('GET', 'https://api.ethermine.org/miner/YOUR_WALLET_HERE/payouts')
    if r.status_code == 200:
        result = json.loads(r.text)
        if 'data' in result.keys() and len(result['data']) > 0:
            minerprops = get_minerprops()
            last_payout = result['data'][0]
            updated = update_minerprops(minerprops, last_payout)
            if updated:
                print '%f' % float(float(last_payout['amount']) * float(0.000000000000000001))
    print ''

def get_minerprops():
    minerprops_raw = open('/path/to/miner_props.json').read()
    return json.loads(minerprops_raw)

def update_minerprops(minerprops, last_payout):
    last_payout_timestamp = str(datetime.datetime.fromtimestamp(last_payout['paidOn']))
    updated = False
    if minerprops['lastPayoutTimestamp'] != last_payout_timestamp:
        updated = True
        minerprops['lastPayoutTimestamp'] = last_payout_timestamp
        minerprops['lastPayoutAmount'] = last_payout['amount']
        with open('/path/to/miner_props.json', 'w') as fp:
            json.dump(minerprops, fp, indent=4)
        return True
    return False

if __name__ == "__main__":
    main()
