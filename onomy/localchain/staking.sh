


# onomyd keys list --keyring-backend=test --home=$HOME/.onomyd/validator1

echo $(cat /Users/donglieu/script/keys/mnemonic4)| onomyd keys add vi4 --recover --keyring-backend=test --home=$HOME/.onomyd/validator1
echo $(cat /Users/donglieu/script/keys/mnemonic5)| onomyd keys add vi5 --recover --keyring-backend=test --home=$HOME/.onomyd/validator1
echo $(cat /Users/donglieu/script/keys/mnemonic6)| onomyd keys add vi6 --recover --keyring-backend=test --home=$HOME/.onomyd/validator1
echo $(cat /Users/donglieu/script/keys/mnemonic7)| onomyd keys add vi7 --recover --keyring-backend=test --home=$HOME/.onomyd/validator1
# onomy1ujyr90wqkqpgp5rlfrvcgagyrwfqdpq9v90eh0

# onomyd keys list --keyring-backend=test --home=$HOME/.onomyd/validator1
sleep 1

onomyd tx bank send onomy1wa3u4knw74r598quvzydvca42qsmk6jrc6uj7m onomy1ujyr90wqkqpgp5rlfrvcgagyrwfqdpq9v90eh0 100000stake --keyring-backend=test --chain-id testing-1 -y --home=$HOME/.onomyd/validator1 
sleep 7
onomyd tx bank send onomy1wa3u4knw74r598quvzydvca42qsmk6jrc6uj7m onomy1qvuhm5m644660nd8377d6l7yz9e9hhm9rd0sqr 100000stake --keyring-backend=test --chain-id testing-1 -y --home=$HOME/.onomyd/validator1 
sleep 7
onomyd tx bank send onomy1wa3u4knw74r598quvzydvca42qsmk6jrc6uj7m onomy16gjg8p5fedy48wf403jwmz2cxlwqtkqlk3ptmx 100000stake --keyring-backend=test --chain-id testing-1 -y --home=$HOME/.onomyd/validator1 
sleep 7
onomyd tx bank send onomy1wa3u4knw74r598quvzydvca42qsmk6jrc6uj7m onomy19wtdcnkcz7pcrvu68du2y8xwh8quw6l7s0qc0v 100000stake --keyring-backend=test --chain-id testing-1 -y --home=$HOME/.onomyd/validator1 

sleep 7

onomyd q bank balances onomy1ujyr90wqkqpgp5rlfrvcgagyrwfqdpq9v90eh0 
onomyd q bank balances onomy1qvuhm5m644660nd8377d6l7yz9e9hhm9rd0sqr 
onomyd q bank balances onomy16gjg8p5fedy48wf403jwmz2cxlwqtkqlk3ptmx 
onomyd q bank balances onomy19wtdcnkcz7pcrvu68du2y8xwh8quw6l7s0qc0v 

sleep 7

onomyd tx staking delegate onomyvaloper1wa3u4knw74r598quvzydvca42qsmk6jrya79zd 10000stake --from vi7 --keyring-backend=test --home=$HOME/.onomyd/validator1 --chain-id testing-1 -y
sleep 5 
onomyd tx staking delegate onomyvaloper1w7f3xx7e75p4l7qdym5msqem9rd4dyc4cju3vm 10000stake --from vi6 --keyring-backend=test --home=$HOME/.onomyd/validator1 --chain-id testing-1 -y
sleep 5
onomyd tx staking delegate onomyvaloper1g9v3zjt6rfkwm4s8sw9wu4jgz9me8pn2c03jft 10000stake --from vi5 --keyring-backend=test --home=$HOME/.onomyd/validator1 --chain-id testing-1 -y
sleep 5
onomyd tx staking delegate onomyvaloper1wa3u4knw74r598quvzydvca42qsmk6jrya79zd 10000stake --from vi4 --keyring-backend=test --home=$HOME/.onomyd/validator1 --chain-id testing-1 -y
sleep 5
onomyd tx staking delegate onomyvaloper1wa3u4knw74r598quvzydvca42qsmk6jrya79zd 10000stake --from vi4 --keyring-backend=test --home=$HOME/.onomyd/validator1 --chain-id testing-1 -y

sleep 5

onomyd q staking delegation onomy1ujyr90wqkqpgp5rlfrvcgagyrwfqdpq9v90eh0 onomyvaloper1wa3u4knw74r598quvzydvca42qsmk6jrya79zd 

onomyd q staking delegation onomy1qvuhm5m644660nd8377d6l7yz9e9hhm9rd0sqr onomyvaloper1wa3u4knw74r598quvzydvca42qsmk6jrya79zd 

sleep 5

onomyd tx staking unbond onomyvaloper1wa3u4knw74r598quvzydvca42qsmk6jrya79zd 10000stake --from vi7 --keyring-backend=test --home=$HOME/.onomyd/validator1 --chain-id testing-1 -y

sleep 7
onomyd q staking delegation onomy1ujyr90wqkqpgp5rlfrvcgagyrwfqdpq9v90eh0 onomyvaloper1wa3u4knw74r598quvzydvca42qsmk6jrya79zd 

onomyd q staking delegation onomy1qvuhm5m644660nd8377d6l7yz9e9hhm9rd0sqr onomyvaloper1wa3u4knw74r598quvzydvca42qsmk6jrya79zd 

onomyd q staking delegation onomy19wtdcnkcz7pcrvu68du2y8xwh8quw6l7s0qc0v onomyvaloper1w7f3xx7e75p4l7qdym5msqem9rd4dyc4cju3vm



# onomyd tx staking unbond onomyvaloper1wa3u4knw74r598quvzydvca42qsmk6jrya79zd 10000stake --from vi4 --keyring-backend=test --home=$HOME/.onomyd/validator1 --chain-id testing-1 -y
onomyd tx staking delegate onomyvaloper1g9v3zjt6rfkwm4s8sw9wu4jgz9me8pn2c03jft 10000stake --from vi6 --keyring-backend=test --home=$HOME/.onomyd/validator1 --chain-id testing-1 -y
onomyd tx staking unbond onomyvaloper1g9v3zjt6rfkwm4s8sw9wu4jgz9me8pn2c03jft 10000stake --from vi5 --keyring-backend=test --home=$HOME/.onomyd/validator1 --chain-id testing-1 -y