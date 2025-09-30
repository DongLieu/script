#!/bin/bash

# 4 node start old binary, (start mainnet)
go install /Users/donglieu/1025/onomy/...
/Users/donglieu/script/onomy/tooling/multinode.sh

sleep 60
## get public key to publickeys.json
onomyd q comet-validator-set --output json > publickeys.json

# pause and start new binary
killall onomyd || true
go install /Users/donglieu/925/onomy/...
## mkdir 
NUMVAL=$(python3 /Users/donglieu/script/onomy/tooling/pubkey.py /Users/donglieu/script/onomy/tooling/publickeys.json /Users/donglieu/.onomyd-tooling)


/Users/donglieu/script/onomy/tooling/config_nodes.sh NUMVAL

# copy data
cp -r /Users/donglieu/.onomyd/validator1/data /Users/donglieu/.onomyd-tooling/validator1/
cp -r /Users/donglieu/.onomyd/validator1/data /Users/donglieu/.onomyd-tooling/validator2/
cp -r /Users/donglieu/.onomyd/validator1/data /Users/donglieu/.onomyd-tooling/validator3/
cp -r /Users/donglieu/.onomyd/validator1/data /Users/donglieu/.onomyd-tooling/validator4/
# /Users/donglieu/925/onomy/

