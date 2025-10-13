rm -rf $HOME/.bcna/

# init chain
bcnad init test --chain-id testing-1

echo $(cat /Users/donglieu/script/keys/mnemonic1)| bcnad keys add val --keyring-backend test  --recover 
echo $(cat /Users/donglieu/script/keys/mnemonic2)| bcnad keys add val2 --keyring-backend test  --recover 

# bcnad genesis add-genesis-account val 1000000000000stake --keyring-backend test
# bcnad genesis add-genesis-account val2 1000000000000stake --keyring-backend test
bcnad genesis add-genesis-account val 10000000000000000000000000000000stake --keyring-backend test
bcnad genesis add-genesis-account val2 10000000000000000000000000000000stake --keyring-backend test


bcnad genesis gentx val  1000000000000stake --keyring-backend test --chain-id testing-1
# # Collect genesis tx 
bcnad genesis collect-gentxs
# # Run this to ensure everything worked and that the genesis file is setup correctly
# bcnad validate
bcnad genesis validate-genesis

sed -i -E 's|minimum-gas-prices = ""|minimum-gas-prices = "0.0001stake"|g' $HOME/.bcna/config/app.toml
# screen -S xionx -t xionx -d -m
bcnad start   --log_level debug