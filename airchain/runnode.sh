rm -rf $HOME/.junction/

# init chain
junctiond init test --chain-id testing-1

echo $(cat /Users/donglieu/script/keys/mnemonic1)| junctiond keys add val --keyring-backend test  --recover 
echo $(cat /Users/donglieu/script/keys/mnemonic2)| junctiond keys add val2 --keyring-backend test  --recover 

junctiond genesis add-genesis-account val 10000000000000000000000000000000stake --keyring-backend test
junctiond genesis add-genesis-account val2 10000000000000000000000000000000stake --keyring-backend test


junctiond genesis gentx val  1000000000000000000000000000000stake --keyring-backend test --chain-id testing-1
# # Collect genesis tx 
junctiond genesis collect-gentxs
# # Run this to ensure everything worked and that the genesis file is setup correctly
# junctiond validate
junctiond genesis validate-genesis

sed -i -E 's|minimum-gas-prices = ""|minimum-gas-prices = "0.0001stake"|g' $HOME/.junction/config/app.toml
# screen -S xionx -t xionx -d -m
junctiond start  