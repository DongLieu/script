


# onomyd keys list --keyring-backend=test --home=$HOME/.onomyd/validator1

echo $(cat /Users/donglieu/script/keys/mnemonic3)| onomyd keys add vi3 --recover --keyring-backend=test --home=$HOME/.onomyd/validator1
echo $(cat /Users/donglieu/script/keys/mnemonic7)| onomyd keys add vi7 --recover --keyring-backend=test --home=$HOME/.onomyd/validator1
# onomy1ujyr90wqkqpgp5rlfrvcgagyrwfqdpq9v90eh0

# onomyd keys list --keyring-backend=test --home=$HOME/.onomyd/validator1

onomyd tx bank send onomy1wa3u4knw74r598quvzydvca42qsmk6jrc6uj7m onomy1ujyr90wqkqpgp5rlfrvcgagyrwfqdpq9v90eh0 100000anom --keyring-backend=test --chain-id onomy-mainnet-1 -y --home=$HOME/.onomyd/validator1 

sleep 5

onomyd tx staking delegate onomyvaloper1qvuhm5m644660nd8377d6l7yz9e9hhm9l2d8u4 10000anom --from vi7 --keyring-backend=test --home=$HOME/.onomyd/validator1 --chain-id onomy-mainnet-1 -y

sleep 5

onomyd q staking delegation onomy1g9v3zjt6rfkwm4s8sw9wu4jgz9me8pn2ygn94a onomy1ujyr90wqkqpgp5rlfrvcgagyrwfqdpq9v90eh0

sleep 5

onomyd tx staking unbond onomyvaloper1qvuhm5m644660nd8377d6l7yz9e9hhm9l2d8u4 10000anom --from vi7 --keyring-backend=test --home=$HOME/.onomyd/validator1 --chain-id onomy-mainnet-1 -y