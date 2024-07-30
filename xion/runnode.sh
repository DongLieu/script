#!/bin/bash
killall xiond || true
rm -rf $HOME/.xiond/


xiond keys add val --keyring-backend test 
xiond keys add test1 --keyring-backend test 
xiond keys add test2 --keyring-backend test 
xiond keys add test3 --keyring-backend test 

# init chain
xiond init test-1 --chain-id testt

# Change parameter token denominations to stake
cat $HOME/.xiond/config/genesis.json | jq '.app_state["staking"]["params"]["bond_denom"]="stake"' > $HOME/.xiond/config/tmp_genesis.json && mv $HOME/.xiond/config/tmp_genesis.json $HOME/.xiond/config/genesis.json
cat $HOME/.xiond/config/genesis.json | jq '.app_state["crisis"]["constant_fee"]["denom"]="stake"' > $HOME/.xiond/config/tmp_genesis.json && mv $HOME/.xiond/config/tmp_genesis.json $HOME/.xiond/config/genesis.json
cat $HOME/.xiond/config/genesis.json | jq '.app_state["gov"]["deposit_params"]["min_deposit"][0]["denom"]="stake"' > $HOME/.xiond/config/tmp_genesis.json && mv $HOME/.xiond/config/tmp_genesis.json $HOME/.xiond/config/genesis.json
cat $HOME/.xiond/config/genesis.json | jq '.app_state["mint"]["params"]["mint_denom"]="stake"' > $HOME/.xiond/config/tmp_genesis.json && mv $HOME/.xiond/config/tmp_genesis.json $HOME/.xiond/config/genesis.json

# Allocate genesis accounts (cosmos formatted addresses)
xiond genesis add-genesis-account val 1000000000000stake --keyring-backend test
xiond genesis add-genesis-account test1 1000000000stake --keyring-backend test
xiond genesis add-genesis-account test2 1000000000stake --keyring-backend test
xiond genesis add-genesis-account test3 50000000stake --keyring-backend test

# Sign genesis transaction
xiond genesis gentx val 1000000stake --keyring-backend test --chain-id testt

# Collect genesis tx
xiond genesis collect-gentxs

# Run this to ensure everything worked and that the genesis file is setup correctly
xiond genesis validate-genesis

# Start the node (remove the --pruning=nothing flag if historical queries are not needed)


screen -S xionx -t xionx -d -m xiond start

sleep 7

test2=$(xiond keys show test1  --keyring-backend test -a)
val2=$(xiond keys show val  --keyring-backend test -a)

xiond tx bank send $val2 $test2 100000stake  --chain-id testt --keyring-backend test --fees 10stake -y #--node tcp://127.0.0.1:26657