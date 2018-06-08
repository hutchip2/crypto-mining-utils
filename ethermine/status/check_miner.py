#!/usr/bin/python

import sys
import json
import requests

def main():
    r = requests.request('GET', 'https://api.ethermine.org/miner/YOUR_WALLET_HERE/workers/monitor')
    if r.status_code == 200:
        result = json.loads(r.text)
        keys = result.keys()
        if 'status' in keys and 'data' in keys:
            if result['status'] == 'OK' and len(result['data']) > 0:
                sys.exit(0)
    sys.exit(1)

if __name__ == "__main__":
    main()
