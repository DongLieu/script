#!/bin/bash

set -e

rm -rf ~/.realio-networkd/validator4

# node 4
mkdir $HOME/.realio-networkd/validator4

realio-networkd init validator4 --chain-id realionetwork_3301-1 --home=$HOME/.realio-networkd/validator4

# realio-networkd keys add validator4 --keyring-backend=test --home=$HOME/.realio-networkd/validator4
echo $(cat /Users/donglieu/script/keys/mnemonic4)| realio-networkd keys add validator4 --recover --keyring-backend=test --home=$HOME/.realio-networkd/validator4
# cosmos1qvuhm5m644660nd8377d6l7yz9e9hhm9evmx3x

VALIDATOR4_APP_TOML=$HOME/.realio-networkd/validator4/config/app.toml

# # validator4
sed -i -E 's|tcp://0.0.0.0:1317|tcp://localhost:1313|g' $VALIDATOR4_APP_TOML
sed -i -E 's|0.0.0.0:9090|localhost:9082|g' $VALIDATOR4_APP_TOML
sed -i -E 's|0.0.0.0:9091|localhost:9083|g' $VALIDATOR4_APP_TOML
# sed -i -E 's|tcp://0.0.0.0:10337|tcp://0.0.0.0:10377|g' $VALIDATOR4_APP_TOML
sed -i -E 's|minimum-gas-prices = ""|minimum-gas-prices = "0.0001stake"|g' $VALIDATOR4_APP_TOML


VALIDATOR4_CONFIG=$HOME/.realio-networkd/validator4/config/config.toml

# # validator4
sed -i -E 's|tcp://127.0.0.1:26658|tcp://127.0.0.1:26646|g' $VALIDATOR4_CONFIG
sed -i -E 's|tcp://127.0.0.1:26657|tcp://127.0.0.1:26645|g' $VALIDATOR4_CONFIG
sed -i -E 's|tcp://0.0.0.0:26656|tcp://0.0.0.0:26644|g' $VALIDATOR4_CONFIG
sed -i -E 's|allow_duplicate_ip = false|allow_duplicate_ip = true|g' $VALIDATOR4_CONFIG
sed -i -E 's|prometheus = false|prometheus = true|g' $VALIDATOR4_CONFIG
sed -i -E 's|prometheus_listen_addr = ":26660"|prometheus_listen_addr = ":26600"|g' $VALIDATOR4_CONFIG

cp $HOME/.realio-network/config/genesis.json $HOME/.realio-networkd/validator4/config/genesis.json

# copy tendermint node id of validator1 to persistent peers of validator2-3
node1=$(realio-networkd tendermint show-node-id)

sed -i -E "s|persistent_peers = \"\"|persistent_peers = \"$node1@localhost:26656\"|g" $HOME/.realio-networkd/validator4/config/config.toml

cp -r .realio-network/data .realio-networkd/validator4
# screen -S realio4 -t realio4 -d -m 
realio-networkd start --home=$HOME/.realio-networkd/validator4

# sleep 7

# json_string=$(realio-networkd tendermint show-validator --home=$HOME/.realio-networkd/validator4)
# PUB_KEY=$(echo $json_string | jq -r '.key')
# jq --arg newKey "$PUB_KEY" '.pubkey.key = $newKey' /Users/donglieu/script/realio/validator4.json > temp_val.json && mv temp_val.json /Users/donglieu/script/realio/validator4.json

# realio-networkd tx staking create-validator /Users/donglieu/script/realio/validator4.json --chain-id=testing-1 --from=cosmos1qvuhm5m644660nd8377d6l7yz9e9hhm9evmx3x --gas=500000 --keyring-backend=test --home=$HOME/.realio-networkd/validator4 -y --fees 500000stake

# sleep 7

# realio-networkd q staking validators

# realiovaloper1j7qsamh9t7mynehxz2svfrpqglyeexty2wfh49
