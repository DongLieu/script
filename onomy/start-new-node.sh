#!/bin/bash

set -e

rm -rf ~/.onomyd/validator5

# node 4
mkdir $HOME/.onomyd/validator5

onomyd init validator5 --chain-id testing-1 --home=$HOME/.onomyd/validator5

# onomyd keys add validator4 --keyring-backend=test --home=$HOME/.onomyd/validator4
echo $(cat /Users/donglieu/script/keys/mnemonic5)| onomyd keys add validator5 --recover --keyring-backend=test --home=$HOME/.onomyd/validator5
# xion1qvuhm5m644660nd8377d6l7yz9e9hhm9m9py8d

VALIDATOR5_APP_TOML=$HOME/.onomyd/validator5/config/app.toml

# # validator4
sed -i -E 's|tcp://localhost:1317|tcp://localhost:1312|g' $VALIDATOR5_APP_TOML
sed -i -E 's|localhost:9090|localhost:9082|g' $VALIDATOR5_APP_TOML
sed -i -E 's|localhost:9091|localhost:9083|g' $VALIDATOR5_APP_TOML
sed -i -E 's|tcp://0.0.0.0:10337|tcp://0.0.0.0:10377|g' $VALIDATOR5_APP_TOML
sed -i -E 's|minimum-gas-prices = ""|minimum-gas-prices = "0.0001stake"|g' $VALIDATOR5_APP_TOML


VALIDATOR5_CONFIG=$HOME/.onomyd/validator5/config/config.toml

# # validator4
sed -i -E 's|tcp://127.0.0.1:26658|tcp://127.0.0.1:26646|g' $VALIDATOR5_CONFIG
sed -i -E 's|tcp://127.0.0.1:26657|tcp://127.0.0.1:26645|g' $VALIDATOR5_CONFIG
sed -i -E 's|tcp://0.0.0.0:26656|tcp://0.0.0.0:26644|g' $VALIDATOR5_CONFIG
sed -i -E 's|allow_duplicate_ip = false|allow_duplicate_ip = true|g' $VALIDATOR5_CONFIG
sed -i -E 's|prometheus = false|prometheus = true|g' $VALIDATOR5_CONFIG
sed -i -E 's|prometheus_listen_addr = ":26660"|prometheus_listen_addr = ":26600"|g' $VALIDATOR5_CONFIG

cp $HOME/.onomyd/validator1/config/genesis.json $HOME/.onomyd/validator5/config/genesis.json

# copy tendermint node id of validator1 to persistent peers of validator2-3
node1=$(onomyd tendermint show-node-id --home=$HOME/.onomyd/validator1)
node2=$(onomyd tendermint show-node-id --home=$HOME/.onomyd/validator2)
node3=$(onomyd tendermint show-node-id --home=$HOME/.onomyd/validator3)
node4=$(onomyd tendermint show-node-id --home=$HOME/.onomyd/validator4)

sed -i -E "s|persistent_peers = \"\"|persistent_peers = \"$node1@localhost:26656,$node2@localhost:26653,$node3@localhost:26650,$node4@localhost:26647\"|g" $HOME/.onomyd/validator5/config/config.toml

# onomyd keys show validator4 -a --keyring-backend=test --home=$HOME/.onomyd/validator4

# screen -S xion4 -t xion4 -d -m 
onomyd start --home=$HOME/.onomyd/validator5

# # sleep 7
# # killall onomyd || true

# onomyd tx staking create-validator /Users/donglieu/script/onomy/stake_val4.json --keyring-backend=test --from validator4 --home=$HOME/.onomyd/validator4 --chain-id=testing-1 --fees 20stake -y

# sleep 7
# echo $(cat /Users/donglieu/script/keys/mnemonic5)| onomyd keys add test1 --recover --keyring-backend=test --home=$HOME/.onomyd/validator1
# sleep 7
# onomyd tx staking delegate onomyvaloper1qvuhm5m644660nd8377d6l7yz9e9hhm9l2d8u4 100000stake --from test1 --keyring-backend=test --home=$HOME/.onomyd/validator1 --chain-id testing-1 -y --fees 20stake



# sleep 7
# onomyd in-place-testnet testing-1 onomyvaloper1qvuhm5m644660nd8377d6l7yz9e9hhm9l2d8u4 --home $HOME/.onomyd/validator4 --skip-confirmation --accounts-to-fund="onomy19wtdcnkcz7pcrvu68du2y8xwh8quw6l7s0qc0v,onomy1w7f3xx7e75p4l7qdym5msqem9rd4dyc4y47xsd"
