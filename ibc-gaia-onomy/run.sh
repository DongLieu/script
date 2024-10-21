#!/bin/bash
killall onomyd || true
killall gaiad || true
killall rly || true

# init genesis 2 chain
/Users/donglieu/script/ibc-gaia-onomy/chain1.sh
/Users/donglieu/script/ibc-gaia-onomy/chain2.sh

echo "Running chain 1"
screen -S onomy -t onomy -d -m onomyd start 

echo "Running chain 2"
screen -S gaia -t gaia -d -m gaiad start --pruning=nothing  --minimum-gas-prices=0.0001stake 

sleep 7
# setup rly
echo "Setup relayer"
/Users/donglieu/script/ibc-gaia-onomy/rly.sh

sleep 7
echo "Running relayer"
screen -S relayerd -t relayerd -d -m rly start --home /Users/donglieu/script/ibc-gaia-onomy/rly

echo "Query balances1..."
echo "Balances gaia:"

gaiad q bank balances $(gaiad keys show val --keyring-backend test -a) --node tcp://127.0.0.1:26654

echo "Balances onomy1:"
onomyd q bank balances $(onomyd keys show val --keyring-backend test -a) 
sleep 7

gaiad tx ibc-transfer transfer transfer channel-0 $(onomyd keys show val --keyring-backend test -a)  10000stake --from val --chain-id testing-2 --yes --keyring-backend test --gas 6000000 --fees 6000000stake --node tcp://127.0.0.1:26654

sleep 14

echo "Query balances2..."
echo "Balances gaia:"

gaiad q bank balances $(gaiad keys show val --keyring-backend test -a) --node tcp://127.0.0.1:26654

echo "Balances onomy2:"
onomyd q bank balances $(onomyd keys show val --keyring-backend test -a) 

