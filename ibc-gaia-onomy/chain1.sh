rm -rf $HOME/.onomy/

# init chain
onomyd init test --chain-id onomy-1

echo $(cat /Users/donglieu/script/keys/mnemonic1)| onomyd keys add val --keyring-backend test  --recover 
echo $(cat /Users/donglieu/script/keys/mnemonic2)| onomyd keys add val2 --keyring-backend test  --recover 

# onomyd genesis add-genesis-account val 1000000000000stake --keyring-backend test
# onomyd genesis add-genesis-account val2 1000000000000stake --keyring-backend test
onomyd genesis add-genesis-account val 10000000000000000000000000000000stake --keyring-backend test
onomyd genesis add-genesis-account val2 10000000000000000000000000000000stake --keyring-backend test


onomyd genesis gentx val  1000000000000000000000000000000stake --keyring-backend test --chain-id onomy-1
# # Collect genesis tx 
onomyd genesis collect-gentxs
# # Run this to ensure everything worked and that the genesis file is setup correctly
# onomyd validate
onomyd genesis validate-genesis

sed -i -E 's|minimum-gas-prices = ""|minimum-gas-prices = "0.0001stake"|g' $HOME/.onomy/config/app.toml
# screen -S xionx -t xionx -d -m
onomyd start