#!/bin/bash
killall aurad || true
killall gaiad || true
killall rly || true

echo "Running chain 1"
screen -S aura -t aura -d -m aurad start --pruning=nothing  --minimum-gas-prices=0.0001stake --home ./node1

echo "Running chain 2"
screen -S gaia -t gaia -d -m gaiad start --pruning=nothing  --minimum-gas-prices=0.0001stake --home ./node2

sleep 7

echo "Running relayer"
screen -S relayerd -t relayerd -d -m rly start --home rly
# ./rly.sh

sleep 7

gaiad tx ibc-transfer transfer transfer channel-3 $(aurad keys show mykey --keyring-backend test -a --home=./node1)  10000stake --from mykey --chain-id cosmoshub-4 --home=./node2 --yes --keyring-backend test --gas 6000000 --fees 6000000stake --node tcp://127.0.0.1:26654

sleep 7

echo "Query balances..."
echo "Balances gaia:"

gaiad q bank balances $(gaiad keys show mykey --keyring-backend test -a --home=./node2) --node tcp://127.0.0.1:26654

echo "Balances aura:"
aurad q bank balances $(aurad keys show mykey --keyring-backend test -a --home=./node1) 

