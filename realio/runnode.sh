#!/bin/bash
killall realio-networkd || true
rm -rf $HOME/.realio-network/

echo $(cat ./keys/mnemonic1)| realio-networkd keys add val1 --keyring-backend test --recover
echo $(cat ./keys/mnemonic2)| realio-networkd keys add val2 --keyring-backend test  --recover

# realio1g4a4jneyjrn7edhhd7l5cx8utgjk8carmkseh6
val1addr=$(realio-networkd keys show val1  --keyring-backend test -a)
# realio1982s57g5kadu2v4ygapne9vj0t7p9d597yr0m8
val2addr=$(realio-networkd keys show val2  --keyring-backend test -a)

# # init chain
realio-networkd init test --chain-id realionetwork_3301-1

# Change parameter token denominations to stake
# cat $HOME/.realio-network/config/genesis.json | jq '.app_state["staking"]["params"]["bond_denom"]="stake"' > $HOME/.realio-network/config/tmp_genesis.json && mv $HOME/.realio-network/config/tmp_genesis.json $HOME/.realio-network/config/genesis.json
# cat $HOME/.realio-network/config/genesis.json | jq '.app_state["crisis"]["constant_fee"]["denom"]="stake"' > $HOME/.realio-network/config/tmp_genesis.json && mv $HOME/.realio-network/config/tmp_genesis.json $HOME/.realio-network/config/genesis.json
# cat $HOME/.realio-network/config/genesis.json | jq '.app_state["gov"]["deposit_params"]["min_deposit"][0]["denom"]="stake"' > $HOME/.realio-network/config/tmp_genesis.json && mv $HOME/.realio-network/config/tmp_genesis.json $HOME/.realio-network/config/genesis.json
# cat $HOME/.realio-network/config/genesis.json | jq '.app_state["mint"]["params"]["mint_denom"]="stake"' > $HOME/.realio-network/config/tmp_genesis.json && mv $HOME/.realio-network/config/tmp_genesis.json $HOME/.realio-network/config/genesis.json

# Allocate genesis accounts (cosmos formatted addresses)
# realio-networkd  add-genesis-account $val1addr 1000000000000stake --keyring-backend test
# realio-networkd  add-genesis-account $val2addr 1000000000stake --keyring-backend test

# # # # Sign genesis transaction
# realio-networkd  gentx val1  100000000000stake --keyring-backend test --chain-id realio_3-2

# # # Collect genesis tx
# realio-networkd  collect-gentxs

# # # Run this to ensure everything worked and that the genesis file is setup correctly
# realio-networkd  validate-genesis

# # # Start the node (remove the --pruning=nothing flag if historical queries are not needed)
# screen -S realio -t realio -d -m realio-networkd start

# sleep 7

# realio-networkd tx bank send $val2 $test2 100000stake  --chain-id realio_3-2 --keyring-backend test --fees 10stake -y #--node tcp://127.0.0.1:26657