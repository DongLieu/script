sleep 7
onomyd tx gov submit-proposal  /Users/donglieu/script/onomy/upgarde-reserve/proposal-1.json --keyring-backend=test  --home=$HOME/.onomy --from val -y --chain-id onomy-mainnet-1 --fees 30stake --gas 300000

sleep 7
onomyd tx gov vote 35 yes  --from val --keyring-backend test --home ~/.onomy --chain-id onomy-mainnet-1 -y --fees 20stake