#!/bin/bash
killall realio-networkd || true
rm -rf $HOME/.realio-network/

# add key
./typeskey/genkeys.sh "realio-networkd" "$HOME/.realio-network"

# realio1g4a4jneyjrn7edhhd7l5cx8utgjk8carmkseh6
val1=$(realio-networkd keys show val1  --keyring-backend test -a)
# realio1982s57g5kadu2v4ygapne9vj0t7p9d597yr0m8
val2=$(realio-networkd keys show val2  --keyring-backend test -a)

# init chain
realio-networkd init test --chain-id realio_3-2

# Change parameter token denominations to stake
cat $HOME/.realio-network/config/genesis.json | jq '.app_state["staking"]["params"]["bond_denom"]="stake"' > $HOME/.realio-network/config/tmp_genesis.json && mv $HOME/.realio-network/config/tmp_genesis.json $HOME/.realio-network/config/genesis.json
cat $HOME/.realio-network/config/genesis.json | jq '.app_state["crisis"]["constant_fee"]["denom"]="stake"' > $HOME/.realio-network/config/tmp_genesis.json && mv $HOME/.realio-network/config/tmp_genesis.json $HOME/.realio-network/config/genesis.json
cat $HOME/.realio-network/config/genesis.json | jq '.app_state["gov"]["deposit_params"]["min_deposit"][0]["denom"]="stake"' > $HOME/.realio-network/config/tmp_genesis.json && mv $HOME/.realio-network/config/tmp_genesis.json $HOME/.realio-network/config/genesis.json
cat $HOME/.realio-network/config/genesis.json | jq '.app_state["mint"]["params"]["mint_denom"]="stake"' > $HOME/.realio-network/config/tmp_genesis.json && mv $HOME/.realio-network/config/tmp_genesis.json $HOME/.realio-network/config/genesis.json

# Allocate genesis accounts (cosmos formatted addresses)
realio-networkd  add-genesis-account $val1 1000000000000stake --keyring-backend test
realio-networkd  add-genesis-account $val2 1000000000stake --keyring-backend test

# Sign genesis transaction
realio-networkd  gentx val1  1000000stake --keyring-backend test --chain-id realio_3-2

# Collect genesis tx
realio-networkd  collect-gentxs

# Run this to ensure everything worked and that the genesis file is setup correctly
realio-networkd  validate-genesis

# Start the node (remove the --pruning=nothing flag if historical queries are not needed)


# screen -S xionx -t xionx -d -m
realio-networkd start

# sleep 7

# realio-networkd tx bank send $val2 $test2 100000stake  --chain-id realio_3-2 --keyring-backend test --fees 10stake -y #--node tcp://127.0.0.1:26657