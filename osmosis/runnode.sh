#!/bin/bash
killall osmosisd || true
rm -rf $HOME/.osmosisd/

# echo $(cat ./keys/mnemonic1)| osmosisd keys add val1 --keyring-backend test --recover
# echo $(cat ./keys/mnemonic2)| osmosisd keys add val3 --keyring-backend test  --recover --home /Users/donglieu/script/xion/node4
echo $(cat /Users/donglieu/script/keys/mnemonic2)| osmosisd keys add val --keyring-backend test  --recover 

# # init chain
# osmosisd init test --chain-id xion-mainnet-1 --home /Users/donglieu/script/xion/node4
osmosisd init test --chain-id gaia-mainnet-1

# Change parameter token denominations to stake
cat $HOME/.osmosisd/config/genesis.json | jq '.app_state["staking"]["params"]["bond_denom"]="stake"' > $HOME/.osmosisd/config/tmp_genesis.json && mv $HOME/.osmosisd/config/tmp_genesis.json $HOME/.osmosisd/config/genesis.json
cat $HOME/.osmosisd/config/genesis.json | jq '.app_state["crisis"]["constant_fee"]["denom"]="stake"' > $HOME/.osmosisd/config/tmp_genesis.json && mv $HOME/.osmosisd/config/tmp_genesis.json $HOME/.osmosisd/config/genesis.json
cat $HOME/.osmosisd/config/genesis.json | jq '.app_state["gov"]["deposit_params"]["min_deposit"][0]["denom"]="stake"' > $HOME/.osmosisd/config/tmp_genesis.json && mv $HOME/.osmosisd/config/tmp_genesis.json $HOME/.osmosisd/config/genesis.json
cat $HOME/.osmosisd/config/genesis.json | jq '.app_state["mint"]["params"]["mint_denom"]="stake"' > $HOME/.osmosisd/config/tmp_genesis.json && mv $HOME/.osmosisd/config/tmp_genesis.json $HOME/.osmosisd/config/genesis.json

sed -i -E 's|minimum-gas-prices = ""|minimum-gas-prices = "0.0001stake"|g' $HOME/.osmosisd/config/app.toml

# Allocate genesis accounts (cosmos formatted addresses)
osmosisd add-genesis-account $(osmosisd keys show val  --keyring-backend test -a) 1000000000000stake --keyring-backend test

# # # Sign genesis transaction
osmosisd gentx val  1000000stake --keyring-backend test --chain-id gaia-mainnet-1

# # Collect genesis tx
osmosisd collect-gentxs

# # Run this to ensure everything worked and that the genesis file is setup correctly
osmosisd validate-genesis

# # Start the node (remove the --pruning=nothing flag if historical queries are not needed)
# # screen -S xionx -t xionx -d -m
osmosisd start   #--minimum-gas-prices=0.0001stake

# sleep 7

# osmosisd tx bank send $val2 $test2 100000stake  --chain-id realio_3-2 --keyring-backend test --fees 10stake -y #--node tcp://127.0.0.1:26657