#!/bin/bash
# killall xiond || true
# rm -rf $HOME/.xiond/

# echo $(cat ./keys/mnemonic1)| xiond keys add val1 --keyring-backend test --recover
echo $(cat ./keys/mnemonic2)| xiond keys add val3 --keyring-backend test  --recover --home /Users/donglieu/script/xion/node4

# # init chain
xiond init test --chain-id xion-mainnet-1 --home /Users/donglieu/script/xion/node4

# # Change parameter token denominations to stake
# cat $HOME/.xiond/config/genesis.json | jq '.app_state["staking"]["params"]["bond_denom"]="stake"' > $HOME/.xiond/config/tmp_genesis.json && mv $HOME/.xiond/config/tmp_genesis.json $HOME/.xiond/config/genesis.json
# cat $HOME/.xiond/config/genesis.json | jq '.app_state["crisis"]["constant_fee"]["denom"]="stake"' > $HOME/.xiond/config/tmp_genesis.json && mv $HOME/.xiond/config/tmp_genesis.json $HOME/.xiond/config/genesis.json
# cat $HOME/.xiond/config/genesis.json | jq '.app_state["gov"]["deposit_params"]["min_deposit"][0]["denom"]="stake"' > $HOME/.xiond/config/tmp_genesis.json && mv $HOME/.xiond/config/tmp_genesis.json $HOME/.xiond/config/genesis.json
# cat $HOME/.xiond/config/genesis.json | jq '.app_state["mint"]["params"]["mint_denom"]="stake"' > $HOME/.xiond/config/tmp_genesis.json && mv $HOME/.xiond/config/tmp_genesis.json $HOME/.xiond/config/genesis.json

# # Allocate genesis accounts (cosmos formatted addresses)
# xiond genesis add-genesis-account $(xiond keys show val1  --keyring-backend test -a) 1000000000000stake --keyring-backend test
# xiond genesis add-genesis-account $(xiond keys show val2  --keyring-backend test -a) 1000000000stake --keyring-backend test

# # # # Sign genesis transaction
# xiond genesis gentx val1  1000000stake --keyring-backend test --chain-id xion-mainnet-1

# # # Collect genesis tx
# xiond genesis collect-gentxs

# # # Run this to ensure everything worked and that the genesis file is setup correctly
# xiond genesis validate-genesis

# # # Start the node (remove the --pruning=nothing flag if historical queries are not needed)
# # # screen -S xionx -t xionx -d -m
# xiond start

# sleep 7

# xiond tx bank send $val2 $test2 100000stake  --chain-id realio_3-2 --keyring-backend test --fees 10stake -y #--node tcp://127.0.0.1:26657