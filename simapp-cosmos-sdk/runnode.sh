#!/bin/bash
# killall simd || true
# rm -rf $HOME/.simd/

# # echo $(cat ./keys/mnemonic1)| simd keys add val1 --keyring-backend test --recover
# # echo $(cat ./keys/mnemonic2)| simd keys add val3 --keyring-backend test  --recover --home /Users/donglieu/script/xion/node4
# echo $(cat /Users/donglieu/script/keys/mnemonic1)| simd keys add val --keyring-backend test  --recover 
# echo "slide moment original seven milk crawl help text kick fluid boring awkward doll wonder sure fragile plate grid hard next casual expire okay body" | testchaind keys add val2 --keyring-backend test  --recover 
# # # init chain
# # simd init test --chain-id xion-mainnet-1 --home /Users/donglieu/script/xion/node4
# simd init test --chain-id xion-mainnet-1

# # Change parameter token denominations to stake
# cat $HOME/.simd/config/genesis.json | jq '.app_state["staking"]["params"]["bond_denom"]="stake"' > $HOME/.simd/config/tmp_genesis.json && mv $HOME/.simd/config/tmp_genesis.json $HOME/.simd/config/genesis.json
# cat $HOME/.simd/config/genesis.json | jq '.app_state["crisis"]["constant_fee"]["denom"]="stake"' > $HOME/.simd/config/tmp_genesis.json && mv $HOME/.simd/config/tmp_genesis.json $HOME/.simd/config/genesis.json
# cat $HOME/.simd/config/genesis.json | jq '.app_state["gov"]["deposit_params"]["min_deposit"][0]["denom"]="stake"' > $HOME/.simd/config/tmp_genesis.json && mv $HOME/.simd/config/tmp_genesis.json $HOME/.simd/config/genesis.json
# cat $HOME/.simd/config/genesis.json | jq '.app_state["mint"]["params"]["mint_denom"]="stake"' > $HOME/.simd/config/tmp_genesis.json && mv $HOME/.simd/config/tmp_genesis.json $HOME/.simd/config/genesis.json

# # Allocate genesis accounts (cosmos formatted addresses)
# simd genesis add-genesis-account xion1wa3u4knw74r598quvzydvca42qsmk6jrqjjxe4 1000000000000stake,100000000uxion --keyring-backend test

# # # # # Sign genesis transaction: xionvaloper1wa3u4knw74r598quvzydvca42qsmk6jrt3eq3x

# simd genesis gentx val  1000000stake --keyring-backend test --chain-id xion-mainnet-1
# echo "============================================="
# # # Collect genesis tx
# simd genesis collect-gentxs
# echo "============================================="
# # # Run this to ensure everything worked and that the genesis file is setup correctly
# simd genesis validate-genesis

# # Start the node (remove the --pruning=nothing flag if historical queries are not needed)
# # screen -S xionx -t xionx -d -m
# simd start

# sleep 7

# simd tx bank send $val2 $test2 100000stake  --chain-id realio_3-2 --keyring-backend test --fees 10stake -y #--node tcp://127.0.0.1:26657


#!/bin/bash
killall simd || true
rm -rf $HOME/.simapp/

echo $(cat /Users/donglieu/script/keys/mnemonic1)| simd keys add val --keyring-backend test  --recover 
echo $(cat /Users/donglieu/script/keys/mnemonic2)| simd keys add val2 --keyring-backend test  --recover 
echo $(cat /Users/donglieu/script/keys/mnemonic3)| simd keys add val3 --keyring-backend test  --recover 
echo $(cat /Users/donglieu/script/keys/mnemonic4)| simd keys add val4 --keyring-backend test  --recover 
# init chain
simd init test --chain-id simd-1

sed -i -E 's|minimum-gas-prices = ""|minimum-gas-prices = "0.0001stake"|g' $HOME/.simd/config/app.toml

simd genesis add-genesis-account cosmos1wa3u4knw74r598quvzydvca42qsmk6jrzmgy07 1000000000000stake --keyring-backend test

simd genesis gentx val  1000000stake --keyring-backend test --chain-id simd-1
# # Collect genesis tx
simd genesis collect-gentxs
# # Run this to ensure everything worked and that the genesis file is setup correctly
simd genesis validate-genesis
# screen -S xionx -t xionx -d -m
simd start


simd tx bank send cosmos1wa3u4knw74r598quvzydvca42qsmk6jrzmgy07 cosmos1w7f3xx7e75p4l7qdym5msqem9rd4dyc4752spg 10000stake --from val --keyring-backend test --chain-id simd-1 --fees 10stake -y


simd tx bank multi-send cosmos1wa3u4knw74r598quvzydvca42qsmk6jrzmgy07 cosmos1w7f3xx7e75p4l7qdym5msqem9rd4dyc4752spg cosmos1g9v3zjt6rfkwm4s8sw9wu4jgz9me8pn27f8nyc cosmos1qvuhm5m644660nd8377d6l7yz9e9hhm9evmx3x 10000stake --from val --keyring-backend test --chain-id simd-1 --fees 10stake -y