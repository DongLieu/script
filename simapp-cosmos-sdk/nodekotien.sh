#!/bin/bash

set -e

# node 5
mkdir $HOME/.xiond/validator5

xiond init validator5 --chain-id testing-1 --home=$HOME/.xiond/validator5

# xion16gjg8p5fedy48wf403jwmz2cxlwqtkqlwe0lug
echo $(cat /Users/donglieu/script/keys/mnemonic5)| xiond keys add validator5 --recover --keyring-backend=test --home=$HOME/.xiond/validator5

VALIDATOR5_APP_TOML=$HOME/.xiond/validator5/config/app.toml

# # validator5
sed -i -E 's|tcp://localhost:1317|tcp://localhost:1312|g' $VALIDATOR5_APP_TOML
sed -i -E 's|localhost:9090|localhost:9078|g' $VALIDATOR5_APP_TOML
sed -i -E 's|localhost:9091|localhost:9079|g' $VALIDATOR5_APP_TOML
sed -i -E 's|tcp://0.0.0.0:10337|tcp://0.0.0.0:10387|g' $VALIDATOR5_APP_TOML


VALIDATOR5_CONFIG=$HOME/.xiond/validator5/config/config.toml

# # validator4
sed -i -E 's|tcp://127.0.0.1:26658|tcp://127.0.0.1:26643|g' $VALIDATOR5_CONFIG
sed -i -E 's|tcp://127.0.0.1:26657|tcp://127.0.0.1:26642|g' $VALIDATOR5_CONFIG
sed -i -E 's|tcp://0.0.0.0:26656|tcp://0.0.0.0:26641|g' $VALIDATOR5_CONFIG
sed -i -E 's|allow_duplicate_ip = false|allow_duplicate_ip = true|g' $VALIDATOR5_CONFIG
sed -i -E 's|prometheus = false|prometheus = true|g' $VALIDATOR5_CONFIG
sed -i -E 's|prometheus_listen_addr = ":26660"|prometheus_listen_addr = ":26590"|g' $VALIDATOR5_CONFIG

cp $HOME/.xiond/validator1/config/genesis.json $HOME/.xiond/validator5/config/genesis.json

# copy tendermint node id of validator1 to persistent peers of validator2-3
node1=$(xiond tendermint show-node-id --home=$HOME/.xiond/validator1)
node2=$(xiond tendermint show-node-id --home=$HOME/.xiond/validator2)
node3=$(xiond tendermint show-node-id --home=$HOME/.xiond/validator3)

sed -i -E "s|persistent_peers = \"\"|persistent_peers = \"$node1@localhost:26656,$node2@localhost:26653,$node3@localhost:26650\"|g" $HOME/.xiond/validator5/config/config.toml


screen -S xion5 -t xion5 -d -m xiond start --home=$HOME/.xiond/validator5

sleep 7

# xiond tx staking create-validator \
#   --amount=1stake \
#   --pubkey=$(xiond tendermint show-validator --home=$HOME/.xiond/validator5) \
#   --moniker=MONIKER-YAZ \
#   --chain-id=testing-1 \
#   --commission-rate=0.05 \
#   --commission-max-rate=0.10 \
#   --commission-max-change-rate=0.01 \
#   --min-self-delegation=1 \
#   --from=xion16gjg8p5fedy48wf403jwmz2cxlwqtkqlwe0lug \
#   --identity="" \
#   --website="" \
#   --details="" \
#   --gas=500000 \
#   --keyring-backend=test \
#   --home=$HOME/.xiond/validator5 \
#   -y