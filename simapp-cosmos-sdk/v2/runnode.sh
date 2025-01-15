
#!/bin/bash
killall simdv2 || true
rm -rf $HOME/.simappv2/

echo $(cat /Users/donglieu/script/keys/mnemonic1)| simdv2 keys add val --keyring-backend test  --recover 
echo $(cat /Users/donglieu/script/keys/mnemonic2)| simdv2 keys add val2 --keyring-backend test  --recover 
echo $(cat /Users/donglieu/script/keys/mnemonic3)| simdv2 keys add val3 --keyring-backend test  --recover 
echo $(cat /Users/donglieu/script/keys/mnemonic4)| simdv2 keys add val4 --keyring-backend test  --recover 
# init chain
simdv2 init test --chain-id simdv2-1

sed -i -E 's|minimum-gas-prices = ""|minimum-gas-prices = "0.0001stake"|g' $HOME/.simappv2/config/app.toml

simdv2 genesis add-genesis-account cosmos1wa3u4knw74r598quvzydvca42qsmk6jrzmgy07 1000000000000stake --keyring-backend test

simdv2 genesis gentx val  1000000stake --keyring-backend test --chain-id simdv2-1
# # Collect genesis tx
simdv2 genesis collect-gentxs
# # Run this to ensure everything worked and that the genesis file is setup correctly
simdv2 genesis validate-genesis
# screen -S xionx -t xionx -d -m
simdv2 start


simdv2 tx bank send cosmos1wa3u4knw74r598quvzydvca42qsmk6jrzmgy07 cosmos1w7f3xx7e75p4l7qdym5msqem9rd4dyc4752spg 10000stake --from val --keyring-backend test --chain-id simdv2-1 --fees 10stake -y


simdv2 tx bank multi-send cosmos1wa3u4knw74r598quvzydvca42qsmk6jrzmgy07 cosmos1w7f3xx7e75p4l7qdym5msqem9rd4dyc4752spg cosmos1g9v3zjt6rfkwm4s8sw9wu4jgz9me8pn27f8nyc cosmos1qvuhm5m644660nd8377d6l7yz9e9hhm9evmx3x 10000stake --from val --keyring-backend test --chain-id simdv2-1 --fees 10stake -yono