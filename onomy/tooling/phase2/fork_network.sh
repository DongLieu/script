#!/bin/bash

# 4 node start old binary, (start mainnet)
cd /Users/donglieu/1025/onomy/
go install ./...
cd /Users/donglieu/script/onomy/tooling/phase2
/Users/donglieu/script/onomy/tooling/multinode.sh

sleep 60
## get public key to publickeys.json
onomyd q comet-validator-set --output json > publickeys.json

# pause and start new binary
killall onomyd || true
onomyd export --home=$HOME/.onomyd/validator1 > tmGenesis.json
cd /Users/donglieu/925/onomy/
go install ./...
cd /Users/donglieu/script/onomy/tooling/phase2
## mkdir 
rm -rf $HOME/.onomyd-tooling2/
mkdir $HOME/.onomyd-tooling2
# ...
onomyd init --chain-id=testing-1 validator1 --home=$HOME/.onomyd-tooling2

NUMVAL=$(python3 /Users/donglieu/script/onomy/tooling/phase2/pubkey.py /Users/donglieu/script/onomy/tooling/phase2/publickeys.json /Users/donglieu/.onomyd-tooling2)

# copy data
cp -r /Users/donglieu/.onomyd/validator1/data /Users/donglieu/.onomyd-tooling2

cp /Users/donglieu/script/onomy/tooling/phase2/tmGenesis.json $HOME/.onomyd-tooling2/config/genesis.json
# config
VALIDATORp2_APP_TOML=$HOME/.onomyd-tooling2/config/app.toml
sed -i -E 's|minimum-gas-prices = ""|minimum-gas-prices = "0.0001stake"|g' $VALIDATORp2_APP_TOML

VALIDATORp2_CONFIG=$HOME/.onomyd-tooling2/config/config.toml
sed -i -E 's|skip_timeout_commit = false|skip_timeout_commit = true|g' $VALIDATORp2_CONFIG
# sed -i -E 's|indexer = "kv"|indexer = "null"|g' $VALIDATORp2_CONFIG

onomyd start --home=$HOME/.onomyd-tooling2 --log_level debug