#!/bin/bash
NUMVAL=$1
PUBKEYS=$2

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

# pubkey 


# change app.toml values
VALIDATOR1_APP_TOML=$HOME/.onomyd-tooling/validator1/config/app.toml
VALIDATOR2_APP_TOML=$HOME/.onomyd-tooling/validator2/config/app.toml
VALIDATOR3_APP_TOML=$HOME/.onomyd-tooling/validator3/config/app.toml
VALIDATOR4_APP_TOML=$HOME/.onomyd-tooling/validator4/config/app.toml

# validator1
# sed -i -E 's|localhost:9090|localhost:9050|g' $VALIDATOR1_APP_TOML
sed -i -E 's|localhost:9090|localhost:9050|g' $VALIDATOR1_APP_TOML
sed -i -E 's|minimum-gas-prices = ""|minimum-gas-prices = "0.0001stake"|g' $VALIDATOR1_APP_TOML

# validator2
sed -i -E 's|tcp://0.0.0.0:1317|tcp://0.0.0.0:1316|g' $VALIDATOR2_APP_TOML
sed -i -E 's|localhost:9090|localhost:9088|g' $VALIDATOR2_APP_TOML
sed -i -E 's|localhost:9091|localhost:9089|g' $VALIDATOR2_APP_TOML
sed -i -E 's|minimum-gas-prices = ""|minimum-gas-prices = "0.0001stake"|g' $VALIDATOR2_APP_TOML

# validator3
sed -i -E 's|tcp://0.0.0.0:1317|tcp://0.0.0.0:1315|g' $VALIDATOR3_APP_TOML
sed -i -E 's|localhost:9090|localhost:9086|g' $VALIDATOR3_APP_TOML
sed -i -E 's|localhost:9091|localhost:9087|g' $VALIDATOR3_APP_TOML
sed -i -E 's|minimum-gas-prices = ""|minimum-gas-prices = "0.0001stake"|g' $VALIDATOR3_APP_TOML

# validator4
sed -i -E 's|tcp://0.0.0.0:1317|tcp://0.0.0.0:1314|g' $VALIDATOR4_APP_TOML
sed -i -E 's|localhost:9090|localhost:9084|g' $VALIDATOR4_APP_TOML
sed -i -E 's|localhost:9091|localhost:9085|g' $VALIDATOR4_APP_TOML
sed -i -E 's|minimum-gas-prices = ""|minimum-gas-prices = "0.0001stake"|g' $VALIDATOR4_APP_TOML


# change config.toml values
VALIDATOR1_CONFIG=$HOME/.onomyd-tooling/validator1/config/config.toml
VALIDATOR2_CONFIG=$HOME/.onomyd-tooling/validator2/config/config.toml
VALIDATOR3_CONFIG=$HOME/.onomyd-tooling/validator3/config/config.toml
VALIDATOR4_CONFIG=$HOME/.onomyd-tooling/validator4/config/config.toml


# validator1
sed -i -E 's|allow_duplicate_ip = false|allow_duplicate_ip = true|g' $VALIDATOR1_CONFIG
sed -i -E 's|prometheus = false|prometheus = true|g' $VALIDATOR1_CONFIG


# validator2
sed -i -E 's|tcp://127.0.0.1:26658|tcp://127.0.0.1:26655|g' $VALIDATOR2_CONFIG
sed -i -E 's|tcp://127.0.0.1:26657|tcp://127.0.0.1:26654|g' $VALIDATOR2_CONFIG
sed -i -E 's|tcp://0.0.0.0:26656|tcp://0.0.0.0:26653|g' $VALIDATOR2_CONFIG
sed -i -E 's|allow_duplicate_ip = false|allow_duplicate_ip = true|g' $VALIDATOR2_CONFIG
sed -i -E 's|prometheus = false|prometheus = true|g' $VALIDATOR2_CONFIG
sed -i -E 's|prometheus_listen_addr = ":26660"|prometheus_listen_addr = ":26630"|g' $VALIDATOR2_CONFIG

# validator3
sed -i -E 's|tcp://127.0.0.1:26658|tcp://127.0.0.1:26652|g' $VALIDATOR3_CONFIG
sed -i -E 's|tcp://127.0.0.1:26657|tcp://127.0.0.1:26651|g' $VALIDATOR3_CONFIG
sed -i -E 's|tcp://0.0.0.0:26656|tcp://0.0.0.0:26650|g' $VALIDATOR3_CONFIG
sed -i -E 's|allow_duplicate_ip = false|allow_duplicate_ip = true|g' $VALIDATOR3_CONFIG
sed -i -E 's|prometheus = false|prometheus = true|g' $VALIDATOR3_CONFIG
sed -i -E 's|prometheus_listen_addr = ":26660"|prometheus_listen_addr = ":26620"|g' $VALIDATOR3_CONFIG

# validator4
sed -i -E 's|tcp://127.0.0.1:26658|tcp://127.0.0.1:26649|g' $VALIDATOR4_CONFIG
sed -i -E 's|tcp://127.0.0.1:26657|tcp://127.0.0.1:26648|g' $VALIDATOR4_CONFIG
sed -i -E 's|tcp://0.0.0.0:26656|tcp://0.0.0.0:26647|g' $VALIDATOR4_CONFIG
sed -i -E 's|allow_duplicate_ip = false|allow_duplicate_ip = true|g' $VALIDATOR4_CONFIG
sed -i -E 's|prometheus = false|prometheus = true|g' $VALIDATOR4_CONFIG
sed -i -E 's|prometheus_listen_addr = ":26660"|prometheus_listen_addr = ":26610"|g' $VALIDATOR4_CONFIG


node1=$(onomyd tendermint show-node-id --home=$HOME/.onomyd-tooling/validator1)
node2=$(onomyd tendermint show-node-id --home=$HOME/.onomyd-tooling/validator2)
node3=$(onomyd tendermint show-node-id --home=$HOME/.onomyd-tooling/validator3)
node4=$(onomyd tendermint show-node-id --home=$HOME/.onomyd-tooling/validator4)
peers="$node1@localhost:26656,$node2@localhost:26653,$node3@localhost:26650,$node4@localhost:26647"