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

gaiad tx ibc-transfer transfer transfer channel-0 $(onomyd keys show val --keyring-backend test -a)  10000000stake --from val --chain-id testing-2 --yes --keyring-backend test --gas 6000000 --fees 6000000stake --node tcp://127.0.0.1:26654
onomyd tx ibc-transfer transfer transfer channel-0 cosmos1w7f3xx7e75p4l7qdym5msqem9rd4dyc4752spg  10000000anom --from val --chain-id testing-1 --yes --keyring-backend test --gas 6000000 --fees 6000000stake 

sleep 14

sleep 7
gaiad q bank balances cosmos1w7f3xx7e75p4l7qdym5msqem9rd4dyc4752spg --node tcp://127.0.0.1:26654
onomyd q bank balances $(onomyd keys show val --keyring-backend test -a) 
onomyd q bank balances onomy1w7f3xx7e75p4l7qdym5msqem9rd4dyc4y47xsd
sleep 7
onomyd tx gov submit-proposal  /Users/donglieu/script/onomy/update-v2.2.0/upgrade2_2_0.json --keyring-backend=test  --home=$HOME/.onomyd/validator1 --from onomy1wa3u4knw74r598quvzydvca42qsmk6jrc6uj7m -y --chain-id testing-1 --fees 20stake
sleep 7
onomyd tx gov vote 1 yes  --from validator1 --keyring-backend test --home ~/.onomyd/validator1 --chain-id testing-1 -y --fees 20stake
# onomyd tx ibc-transfer transfer transfer channel-0 cosmos1w7f3xx7e75p4l7qdym5msqem9rd4dyc4752spg  10000ono --from val --chain-id testing-1 --yes --keyring-backend test --gas 6000000 --fees 6000000stake

# gaiad tx ibc-transfer transfer transfer channel-0 onomy1w7f3xx7e75p4l7qdym5msqem9rd4dyc4y47xsd  10000ibc/0EEDE4D6082034D6CD465BD65761C305AACC6FCA1246F87D6A3C1F5488D18A7B --from val --chain-id testing-2 --yes --keyring-backend test --gas 6000000 --fees 6000000stake --node tcp://127.0.0.1:26654

# gaiad tx ibc-transfer transfer transfer channel-0 onomy1w7f3xx7e75p4l7qdym5msqem9rd4dyc4y47xsd  10000ibc/123276ED3F6C39D8A038A8B96A69DFF82AA131EB7B70EE17FBA1F52A088B743F --from val --chain-id testing-2 --yes --keyring-backend test --gas 6000000 --fees 6000000stake --node tcp://127.0.0.1:26654


# gaiad tx ibc-transfer transfer transfer channel-0 onomy1w7f3xx7e75p4l7qdym5msqem9rd4dyc4y47xsd  9990000ibc/0EEDE4D6082034D6CD465BD65761C305AACC6FCA1246F87D6A3C1F5488D18A7B --from val --chain-id testing-2 --yes --keyring-backend test --gas 6000000 --fees 6000000stake --node tcp://127.0.0.1:26654

# onomyd q bank balances onomy1w7f3xx7e75p4l7qdym5msqem9rd4dyc4y47xsd

# onomyd q bank balances onomy1a53udazy8ayufvy0s434pfwjcedzqv34vdkn6t