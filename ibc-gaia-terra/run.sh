#!/bin/bash
killall terrad || true
killall gaiad || true
killall rly || true

# init genesis 2 chain
/Users/donglieu/script/ibc-gaia-terra/chain1.sh
/Users/donglieu/script/ibc-gaia-terra/chain2.sh

echo "Running chain 1"
screen -S terra -t terra -d -m terrad start 

echo "Running chain 2"
screen -S gaia -t gaia -d -m gaiad start --pruning=nothing  --minimum-gas-prices=0.0001stake 

sleep 7
# setup rly
/Users/donglieu/script/ibc-gaia-terra/rly.sh

sleep 7
echo "Running relayer"
screen -S relayerd -t relayerd -d -m rly start --home /Users/donglieu/script/ibc-gaia-terra/rly

echo "Query balances1..."
echo "Balances gaia:"

gaiad q bank balances $(gaiad keys show val --keyring-backend test -a) --node tcp://127.0.0.1:26654

echo "Balances terra1:"
terrad q bank balances $(terrad keys show val --keyring-backend test -a) 
sleep 7

gaiad tx ibc-transfer transfer transfer channel-0 $(terrad keys show val --keyring-backend test -a)  10000stake --from val --chain-id testing-2 --yes --keyring-backend test --gas 6000000 --fees 6000000stake --node tcp://127.0.0.1:26654

sleep 14

echo "Query balances2..."
echo "Balances gaia:"

gaiad q bank balances $(gaiad keys show val --keyring-backend test -a) --node tcp://127.0.0.1:26654

echo "Balances terra2:"
terrad q bank balances $(terrad keys show val --keyring-backend test -a) 

