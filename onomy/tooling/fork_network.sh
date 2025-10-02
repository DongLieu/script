#!/bin/bash

# 4 node start old binary, (start mainnet)
cd /Users/donglieu/1025/onomy/
go install ./...
cd /Users/donglieu/script/onomy/tooling
/Users/donglieu/script/onomy/tooling/multinode.sh

sleep 60
## get public key to publickeys.json
onomyd q comet-validator-set --output json > publickeys.json

# pause and start new binary
killall onomyd || true
onomyd export --home=$HOME/.onomyd/validator1 > tmGenesis.json
cd /Users/donglieu/925/onomy/
go install ./...
cd /Users/donglieu/script/onomy/tooling
# go install /Users/donglieu/925/onomy/...
## mkdir 
rm -rf $HOME/.onomyd-tooling/
mkdir $HOME/.onomyd-tooling
mkdir $HOME/.onomyd-tooling/validator1
mkdir $HOME/.onomyd-tooling/validator2
mkdir $HOME/.onomyd-tooling/validator3
mkdir $HOME/.onomyd-tooling/validator4
# ...
onomyd init --chain-id=testing-1 validator1 --home=$HOME/.onomyd-tooling/validator1
onomyd init --chain-id=testing-1 validator2 --home=$HOME/.onomyd-tooling/validator2
onomyd init --chain-id=testing-1 validator3 --home=$HOME/.onomyd-tooling/validator3
onomyd init --chain-id=testing-1 validator4 --home=$HOME/.onomyd-tooling/validator4

NUMVAL=$(python3 /Users/donglieu/script/onomy/tooling/pubkey.py /Users/donglieu/script/onomy/tooling/publickeys.json /Users/donglieu/.onomyd-tooling)

# copy data
cp -r /Users/donglieu/.onomyd/validator1/data /Users/donglieu/.onomyd-tooling/validator1/
cp -r /Users/donglieu/.onomyd/validator1/data /Users/donglieu/.onomyd-tooling/validator2/
cp -r /Users/donglieu/.onomyd/validator1/data /Users/donglieu/.onomyd-tooling/validator3/
cp -r /Users/donglieu/.onomyd/validator1/data /Users/donglieu/.onomyd-tooling/validator4/

cp /Users/donglieu/script/onomy/tooling/tmGenesis.json $HOME/.onomyd-tooling/validator1/config/genesis.json
cp /Users/donglieu/script/onomy/tooling/tmGenesis.json $HOME/.onomyd-tooling/validator2/config/genesis.json
cp /Users/donglieu/script/onomy/tooling/tmGenesis.json $HOME/.onomyd-tooling/validator3/config/genesis.json
cp /Users/donglieu/script/onomy/tooling/tmGenesis.json $HOME/.onomyd-tooling/validator4/config/genesis.json
# config
/Users/donglieu/script/onomy/tooling/config_nodes.sh

/Users/donglieu/script/onomy/tooling/start_nodes.sh