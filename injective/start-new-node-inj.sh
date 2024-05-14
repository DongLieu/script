#!/bin/bash

set -e

rm -rf ~/.injectived/validator5

# node 5
mkdir $HOME/.injectived/validator5

injectived init validator5 --chain-id testing-1 --home=$HOME/.injectived/validator5

injectived keys add validator5 --keyring-backend=test --home=$HOME/.injectived/validator5

VALIDATOR5_APP_TOML=$HOME/.injectived/validator5/config/app.toml

# # validator5
sed -i -E 's|tcp://0.0.0.0:1317|tcp://0.0.0.0:1313|g' $VALIDATOR5_APP_TOML
sed -i -E 's|0.0.0.0:9090|0.0.0.0:9082|g' $VALIDATOR5_APP_TOML
sed -i -E 's|0.0.0.0:9091|0.0.0.0:9083|g' $VALIDATOR5_APP_TOML
sed -i -E 's|tcp://0.0.0.0:10337|tcp://0.0.0.0:10377|g' $VALIDATOR5_APP_TOML


VALIDATOR5_CONFIG=$HOME/.injectived/validator5/config/config.toml

# # validator5
sed -i -E 's|tcp://127.0.0.1:26658|tcp://127.0.0.1:26639|g' $VALIDATOR5_CONFIG
sed -i -E 's|tcp://127.0.0.1:26657|tcp://127.0.0.1:26638|g' $VALIDATOR5_CONFIG
sed -i -E 's|tcp://0.0.0.0:26656|tcp://0.0.0.0:26644|g' $VALIDATOR5_CONFIG
sed -i -E 's|allow_duplicate_ip = false|allow_duplicate_ip = true|g' $VALIDATOR5_CONFIG
sed -i -E 's|prometheus = false|prometheus = true|g' $VALIDATOR5_CONFIG
sed -i -E 's|prometheus_listen_addr = ":26660"|prometheus_listen_addr = ":26690"|g' $VALIDATOR5_CONFIG

cp $HOME/.injectived/validator1/config/genesis.json $HOME/.injectived/validator5/config/genesis.json

# copy tendermint node id of validator1 to persistent peers of validator2-3
node1=$(injectived tendermint show-node-id --home=$HOME/.injectived/validator1)
node2=$(injectived tendermint show-node-id --home=$HOME/.injectived/validator2)
node3=$(injectived tendermint show-node-id --home=$HOME/.injectived/validator3)

sed -i -E "s|persistent_peers = \"\"|persistent_peers = \"$node1@localhost:26656,$node2@localhost:26656,$node3@localhost:26656\"|g" $HOME/.injectived/validator5/config/config.toml

injectived start --home=$HOME/.injectived/validator5