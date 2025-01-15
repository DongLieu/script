rm -rf $HOME/.dozozo/

# init chain
dozozod init test --chain-id testing-1

echo $(cat /Users/donglieu/script/keys/mnemonic1)| dozozod keys add val --keyring-backend test  --recover 
echo $(cat /Users/donglieu/script/keys/mnemonic2)| dozozod keys add val2 --keyring-backend test  --recover 
echo $(cat /Users/donglieu/script/keys/mnemonic3)| dozozod keys add val3 --keyring-backend test  --recover 

# dozozod genesis add-genesis-account val 1000000000000stake --keyring-backend test
# dozozod genesis add-genesis-account val2 1000000000000stake --keyring-backend test
dozozod genesis add-genesis-account val 10000000000000000000000000000000stake,10000000000000000000000000000000anom --keyring-backend test
dozozod genesis add-genesis-account val2 10000000000000000000000000000000stake --keyring-backend test
dozozod genesis add-genesis-account val3 10000000000000000000000000000000stake --keyring-backend test


dozozod genesis gentx val  100000000000000000stake --keyring-backend test --chain-id testing-1
# # Collect genesis tx 
dozozod genesis collect-gentxs
# # Run this to ensure everything worked and that the genesis file is setup correctly
# dozozod validate
dozozod genesis validate-genesis

sed -i -E 's|minimum-gas-prices = ""|minimum-gas-prices = "0.000stake"|g' $HOME/.dozozo/config/app.toml

dozozod start 

dozozod q accounts  

dozozod tx bank send val cosmos1w7f3xx7e75p4l7qdym5msqem9rd4dyc4752spg 1000ono --from val --keyring-backend test  --chain-id testing-1 -y

dozozod tx gov submit-proposal  /Users/donglieu/script/onomy/du-upgarde.json --keyring-backend=test  --from val -y --chain-id testing-1 --fees 20stake

dozozod q accounts query cosmos1wa3u4knw74r598quvzydvca42qsmk6jrzmgy07 cosmos.bank.v1beta1.QueryBalanceRequest "{\"address\":\"cosmos1wa3u4knw74r598quvzydvca42qsmk6jrzmgy07\",\"denom\":\"anom\"}"