rm -rf $HOME/.injectived/

# init chain
injectived init test --chain-id testing-1

echo $(cat /Users/donglieu/script/keys/mnemonic1)| injectived keys add val --keyring-backend test  --recover 
echo $(cat /Users/donglieu/script/keys/mnemonic2)| injectived keys add val2 --keyring-backend test  --recover 

# injectived genesis add-genesis-account val 1000000000000stake --keyring-backend test
# injectived genesis add-genesis-account val2 1000000000000stake --keyring-backend test
injectived genesis add-genesis-account val 10000000000000000000000000000000stake --keyring-backend test  --chain-id testing-1
injectived genesis add-genesis-account val2 10000000000000000000000000000000stake --keyring-backend test  --chain-id testing-1


injectived genesis gentx val  1000000000000000000000000stake --keyring-backend test --chain-id testing-1
# # Collect genesis tx 
injectived genesis collect-gentxs
# # Run this to ensure everything worked and that the genesis file is setup correctly
# injectived validate
injectived genesis validate-genesis

sed -i -E 's|minimum-gas-prices = ""|minimum-gas-prices = "0.0001stake"|g' $HOME/.injectived/config/app.toml
# screen -S xionx -t xionx -d -m
injectived start 