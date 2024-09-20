#!/bin/bash
# killall xiond || true
# rm -rf $HOME/.xiond/

# # echo $(cat ./keys/mnemonic1)| xiond keys add val1 --keyring-backend test --recover
# # echo $(cat ./keys/mnemonic2)| xiond keys add val3 --keyring-backend test  --recover --home /Users/donglieu/script/xion/node4
# echo $(cat /Users/donglieu/script/keys/mnemonic1)| xiond keys add val --keyring-backend test  --recover 
# echo "slide moment original seven milk crawl help text kick fluid boring awkward doll wonder sure fragile plate grid hard next casual expire okay body" | testchaind keys add val2 --keyring-backend test  --recover 
# # # init chain
# # xiond init test --chain-id xion-mainnet-1 --home /Users/donglieu/script/xion/node4
# xiond init test --chain-id xion-mainnet-1

# # Change parameter token denominations to stake
# cat $HOME/.xiond/config/genesis.json | jq '.app_state["staking"]["params"]["bond_denom"]="stake"' > $HOME/.xiond/config/tmp_genesis.json && mv $HOME/.xiond/config/tmp_genesis.json $HOME/.xiond/config/genesis.json
# cat $HOME/.xiond/config/genesis.json | jq '.app_state["crisis"]["constant_fee"]["denom"]="stake"' > $HOME/.xiond/config/tmp_genesis.json && mv $HOME/.xiond/config/tmp_genesis.json $HOME/.xiond/config/genesis.json
# cat $HOME/.xiond/config/genesis.json | jq '.app_state["gov"]["deposit_params"]["min_deposit"][0]["denom"]="stake"' > $HOME/.xiond/config/tmp_genesis.json && mv $HOME/.xiond/config/tmp_genesis.json $HOME/.xiond/config/genesis.json
# cat $HOME/.xiond/config/genesis.json | jq '.app_state["mint"]["params"]["mint_denom"]="stake"' > $HOME/.xiond/config/tmp_genesis.json && mv $HOME/.xiond/config/tmp_genesis.json $HOME/.xiond/config/genesis.json

# # Allocate genesis accounts (cosmos formatted addresses)
# xiond genesis add-genesis-account xion1wa3u4knw74r598quvzydvca42qsmk6jrqjjxe4 1000000000000stake,100000000uxion --keyring-backend test

# # # # # Sign genesis transaction: xionvaloper1wa3u4knw74r598quvzydvca42qsmk6jrt3eq3x

# xiond genesis gentx val  1000000stake --keyring-backend test --chain-id xion-mainnet-1
# echo "============================================="
# # # Collect genesis tx
# xiond genesis collect-gentxs
# echo "============================================="
# # # Run this to ensure everything worked and that the genesis file is setup correctly
# xiond genesis validate-genesis

# # Start the node (remove the --pruning=nothing flag if historical queries are not needed)
# # screen -S xionx -t xionx -d -m
# xiond start

# sleep 7

# xiond tx bank send $val2 $test2 100000stake  --chain-id realio_3-2 --keyring-backend test --fees 10stake -y #--node tcp://127.0.0.1:26657


#!/bin/bash
killall xiond || true
rm -rf $HOME/.xiond/

echo $(cat /Users/donglieu/script/keys/mnemonic1)| xiond keys add val --keyring-backend test  --recover 
# init chain
xiond init test --chain-id xiond-1

sed -i -E 's|minimum-gas-prices = ""|minimum-gas-prices = "0.0001stake"|g' $HOME/.xiond/config/app.toml

xiond genesis add-genesis-account xion1wa3u4knw74r598quvzydvca42qsmk6jrqjjxe4 1000000000000stake --keyring-backend test

xiond genesis gentx val  1000000stake --keyring-backend test --chain-id xiond-1
# # Collect genesis tx
xiond genesis collect-gentxs
# # Run this to ensure everything worked and that the genesis file is setup correctly
xiond genesis validate-genesis
# screen -S xionx -t xionx -d -m
xiond start
