
# height= + 20
onomyd tx gov submit-proposal software-upgrade v2.0.0  --upgrade-info v2.0.0 --upgrade-height 9698860  --title upgrade --description upgrade --from validator1 --keyring-backend test --home $HOME/.onomyd/validator1 --chain-id onomy-mainnet-1 --deposit 1000000000000anom -y --node tcp://127.0.0.1:26654

sleep 7

onomyd tx gov vote 31 yes  --from validator1 --keyring-backend test --home ~/.onomyd/validator1 --chain-id onomy-mainnet-1 -y 

onomyd tx gov vote 31 yes  --from validator2 --keyring-backend test --home ~/.onomyd/validator2 --chain-id onomy-mainnet-1 -y 

onomyd tx gov vote 31 yes  --from validator3 --keyring-backend test --home ~/.onomyd/validator3 --chain-id onomy-mainnet-1 -y 

onomyd tx gov vote 31 yes  --from val --keyring-backend test --home ~/.onomy --chain-id onomy-mainnet-1 -y 