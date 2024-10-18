#!/bin/bash
killall onomyd || true
killall gaiad || true
killall rly || true

echo "Running chain 1"
screen -S onomy -t onomy -d -m onomyd start 

echo "Running chain 2"
screen -S gaia -t gaia -d -m gaiad start --pruning=nothing  --minimum-gas-prices=0.0001stake 

sleep 7

echo "Running relayer"
screen -S relayerd -t relayerd -d -m rly start --home /Users/donglieu/script/ibc-chainnel/rly
# ./rly.sh

sleep 7

gaiad tx ibc-transfer transfer transfer channel-3 $(onomyd keys show val --keyring-backend test -a)  10000stake --from val --chain-id testing-2 --yes --keyring-backend test --gas 6000000 --fees 6000000stake --node tcp://127.0.0.1:26654

sleep 7

echo "Query balances..."
echo "Balances gaia:"

gaiad q bank balances $(gaiad keys show val --keyring-backend test -a) --node tcp://127.0.0.1:26654

echo "Balances onomy:"
onomyd q bank balances $(onomyd keys show mykey --keyring-backend test -a) 

