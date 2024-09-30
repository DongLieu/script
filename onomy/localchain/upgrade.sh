
# onomyd tx staking unbond onomyvaloper1g9v3zjt6rfkwm4s8sw9wu4jgz9me8pn2c03jft 10000stake --from vi6 --keyring-backend=test --home=$HOME/.onomyd/validator1 --chain-id testing-1 -y
sleep 7

onomyd tx gov submit-proposal software-upgrade v1.1.6  --upgrade-info v1.1.6 --upgrade-height 50  --title upgrade --description upgrade --from validator1 --keyring-backend test --home $HOME/.onomyd/validator1 --chain-id testing-1 --deposit 1000000000000000000stake -y 

sleep 7
onomyd tx gov vote 1 yes  --from validator1 --keyring-backend test --home ~/.onomyd/validator1 --chain-id testing-1 -y 
onomyd tx gov vote 1 yes  --from validator2 --keyring-backend test --home ~/.onomyd/validator2 --chain-id testing-1 -y 
onomyd tx gov vote 1 yes  --from validator3 --keyring-backend test --home ~/.onomyd/validator3 --chain-id testing-1 -y 
sleep 7
onomyd tx staking unbond onomyvaloper1g9v3zjt6rfkwm4s8sw9wu4jgz9me8pn2c03jft 10000stake --from vi6 --keyring-backend=test --home=$HOME/.onomyd/validator1 --chain-id testing-1 -y
