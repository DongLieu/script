#!/bin/bash
rm -rf /Users/donglieu/script/ibc-gaia-realio/rly
mkdir /Users/donglieu/script/ibc-gaia-realio/rly

rly config init --home /Users/donglieu/script/ibc-gaia-realio/rly


cp /Users/donglieu/script/ibc-gaia-realio/config.yaml /Users/donglieu/script/ibc-gaia-realio/rly/config/config.yaml
# edit config.yam
# add keys
rly keys add gaia test --home /Users/donglieu/script/ibc-gaia-realio/rly
rly keys add realio-network test --home /Users/donglieu/script/ibc-gaia-realio/rly

rly paths new testing-2 realionetwork_3301-1 demo --home /Users/donglieu/script/ibc-gaia-realio/rly

gaiad tx bank send val $(rly keys show gaia test --home /Users/donglieu/script/ibc-gaia-realio/rly) 10000000stake --node http://localhost:26654 --fees 200000stake -y --keyring-backend test
realio-networkd tx bank send val1 $(rly keys show realio-network test --home /Users/donglieu/script/ibc-gaia-realio/rly) 100000000000000000stake -y --gas-prices 100000stake --keyring-backend test --chain-id realionetwork_3301-1
sleep 7
rly tx clients demo --home /Users/donglieu/script/ibc-gaia-realio/rly

sleep 7
rly tx connection demo --home /Users/donglieu/script/ibc-gaia-realio/rly

sleep 7
rly tx channel demo --src-port transfer --dst-port transfer --order unordered --version ics20-1 --home /Users/donglieu/script/ibc-gaia-realio/rly
