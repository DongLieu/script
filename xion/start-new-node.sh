#!/bin/bash

set -e

rm -rf ~/.xiond/validator5

# node 5
mkdir $HOME/.xiond/validator5

xiond init validator5 --chain-id testing-1 --home=$HOME/.xiond/validator5

xiond keys add validator5 --keyring-backend=test --home=$HOME/.xiond/validator5

VALIDATOR5_APP_TOML=$HOME/.xiond/validator5/config/app.toml

# # validator5
sed -i -E 's|tcp://localhost:1317|tcp://localhost:1313|g' $VALIDATOR5_APP_TOML
sed -i -E 's|localhost:9090|localhost:9082|g' $VALIDATOR5_APP_TOML
sed -i -E 's|localhost:9091|localhost:9083|g' $VALIDATOR5_APP_TOML
sed -i -E 's|tcp://0.0.0.0:10337|tcp://0.0.0.0:10377|g' $VALIDATOR5_APP_TOML


VALIDATOR5_CONFIG=$HOME/.xiond/validator5/config/config.toml

# # validator5
sed -i -E 's|tcp://127.0.0.1:26658|tcp://127.0.0.1:26639|g' $VALIDATOR5_CONFIG
sed -i -E 's|tcp://127.0.0.1:26657|tcp://127.0.0.1:26638|g' $VALIDATOR5_CONFIG
sed -i -E 's|tcp://0.0.0.0:26656|tcp://0.0.0.0:26644|g' $VALIDATOR5_CONFIG
sed -i -E 's|allow_duplicate_ip = false|allow_duplicate_ip = true|g' $VALIDATOR5_CONFIG
sed -i -E 's|prometheus = false|prometheus = true|g' $VALIDATOR5_CONFIG
sed -i -E 's|prometheus_listen_addr = ":26660"|prometheus_listen_addr = ":26690"|g' $VALIDATOR5_CONFIG

cp $HOME/.xiond/validator1/config/genesis.json $HOME/.xiond/validator5/config/genesis.json

# copy tendermint node id of validator1 to persistent peers of validator2-3
# node1=$(xiond tendermint show-node-id --home=$HOME/.xiond/validator1)
# node2=$(xiond tendermint show-node-id --home=$HOME/.xiond/validator2)
node3=$(xiond tendermint show-node-id --home=$HOME/.xiond/validator3)

sed -i -E "s|persistent_peers = \"\"|persistent_peers = \"$node3@localhost:26650\"|g" $HOME/.xiond/validator5/config/config.toml

xiond keys show validator5 -a --keyring-backend=test --home=$HOME/.xiond/validator5

xiond start --home=$HOME/.xiond/validator5