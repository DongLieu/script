#!/bin/bash
killall onomyd || true
rm -rf $HOME/.onomy

onomyd init test-1 --chain-id testt

onomyd keys add val --keyring-backend test 
onomyd keys add test1 --keyring-backend test 
onomyd keys add test2 --keyring-backend test 
onomyd keys add test3 --keyring-backend test 

# init chain
# onomyd init test-1 --chain-id testt

# Change parameter token denominations to stake
cat $HOME/.onomy/config/genesis.json | jq '.app_state["staking"]["params"]["bond_denom"]="stake"' > $HOME/.onomy/config/tmp_genesis.json && mv $HOME/.onomy/config/tmp_genesis.json $HOME/.onomy/config/genesis.json
# cat $HOME/.onomy/config/genesis.json | jq '.app_state["crisis"]["constant_fee"]["denom"]="stake"' > $HOME/.onomy/config/tmp_genesis.json && mv $HOME/.onomy/config/tmp_genesis.json $HOME/.onomy/config/genesis.json
# cat $HOME/.onomy/config/genesis.json | jq '.app_state["gov"]["deposit_params"]["min_deposit"][0]["denom"]="stake"' > $HOME/.onomy/config/tmp_genesis.json && mv $HOME/.onomy/config/tmp_genesis.json $HOME/.onomy/config/genesis.json
cat $HOME/.onomy/config/genesis.json | jq '.app_state["mint"]["params"]["mint_denom"]="stake"' > $HOME/.onomy/config/tmp_genesis.json && mv $HOME/.onomy/config/tmp_genesis.json $HOME/.onomy/config/genesis.json

# Allocate genesis accounts (cosmos formatted addresses)
onomyd add-genesis-account val 1000000000000stake --keyring-backend test
onomyd add-genesis-account test1 1000000000stake --keyring-backend test
onomyd add-genesis-account test2 1000000000stake --keyring-backend test
onomyd add-genesis-account test3 50000000stake --keyring-backend test

# Sign genesis transaction
onomyd gentx val 1000000stake --keyring-backend test --chain-id testt

# Collect genesis tx
onomyd collect-gentxs

# Run this to ensure everything worked and that the genesis file is setup correctly
onomyd validate-genesis

# Start the node (remove the --pruning=nothing flag if historical queries are not needed)


# screen -S onomyx -t onomyx -d -m 
onomyd start

# sleep 7

# test2=$(onomyd keys show test1  --keyring-backend test -a)
# val2=$(onomyd keys show val  --keyring-backend test -a)

# onomyd tx bank send $val2 $test2 100000stake  --chain-id testt --keyring-backend test --fees 10stake -y #--node tcp://127.0.0.1:26657