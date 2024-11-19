rm -rf $HOME/.onomy/

# init chain
onomyd init test --chain-id testing-1

echo $(cat /Users/donglieu/script/keys/mnemonic1)| onomyd keys add val --keyring-backend test  --recover 
echo $(cat /Users/donglieu/script/keys/mnemonic2)| onomyd keys add val2 --keyring-backend test  --recover 

# onomyd genesis add-genesis-account val 1000000000000stake --keyring-backend test
# onomyd genesis add-genesis-account val2 1000000000000stake --keyring-backend test
onomyd genesis add-genesis-account val 10000000000000000000000000000000stake,10000000000000000000000000000000anom --keyring-backend test
onomyd genesis add-genesis-account val2 10000000000000000000000000000000stake --keyring-backend test


onomyd genesis gentx val  1000000000000000000000000000000stake --keyring-backend test --chain-id testing-1
# # Collect genesis tx 
onomyd genesis collect-gentxs
# # Run this to ensure everything worked and that the genesis file is setup correctly
# onomyd validate
onomyd genesis validate-genesis

sed -i -E 's|minimum-gas-prices = ""|minimum-gas-prices = "0.0001stake"|g' $HOME/.onomy/config/app.toml

update_test_genesis () {
    # Ví dụ: update_test_genesis '.consensus_params["block"]["max_gas"]="100000000"'
    cat $HOME/.onomy/config/genesis.json | jq "$1" > tmp.json && mv tmp.json $HOME/.onomy/config/genesis.json
}

# Cập nhật các trường trong genesis.json
update_test_genesis '.app_state["gov"]["voting_params"]["voting_period"] = "150s"'
update_test_genesis '.app_state["gov"]["params"]["voting_period"] = "150s"'
# update_test_genesis '.app_state["staking"]["params"]["bond_denom"] = "anom"'
update_test_genesis '.app_state["staking"]["params"]["unbonding_time"] = "150s"'

# Cập nhật tất cả các phần tử của min_deposit và expedited_min_deposit
update_test_genesis '.app_state["gov"]["params"]["min_deposit"] |= map(if .denom == "stake" then .denom = "anom" else . end)'
update_test_genesis '.app_state["gov"]["params"]["expedited_min_deposit"] |= map(if .denom == "stake" then .denom = "anom" else . end)'

# screen -S xionx -t xionx -d -m
# onomyd start 