
echo $(cat /Users/donglieu/script/keys/mnemonic7)| onomyd keys add vi7 --recover --keyring-backend=test --home=$HOME/.onomyd/validator1

sleep 7

onomyd tx bank send onomy19wtdcnkcz7pcrvu68du2y8xwh8quw6l7s0qc0v onomy1ujyr90wqkqpgp5rlfrvcgagyrwfqdpq9v90eh0 100000anom --keyring-backend=test --chain-id onomy-mainnet-1 -y --home=$HOME/.onomyd/validator1 

sleep 7

onomyd tx staking delegate onomyvaloper16gjg8p5fedy48wf403jwmz2cxlwqtkql2kru8s 10000anom --from vi7 --keyring-backend=test --home=$HOME/.onomyd/validator1 --chain-id  onomy-mainnet-1 -y


# sleep 7

# onomyd tx staking unbond onomyvaloper16gjg8p5fedy48wf403jwmz2cxlwqtkql2kru8s 10000anom --from vi7 --keyring-backend=test --home=$HOME/.onomyd/validator1 --chain-id onomy-mainnet-1 -y
