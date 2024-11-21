#!/bin/bash
rm -rf /Users/donglieu/script/ibc-gaia-onomy/rly
mkdir /Users/donglieu/script/ibc-gaia-onomy/rly

rly config init --home /Users/donglieu/script/ibc-gaia-onomy/rly


cp /Users/donglieu/script/ibc-gaia-onomy/config.yaml /Users/donglieu/script/ibc-gaia-onomy/rly/config/config.yaml
# edit config.yam
# add keys
rly keys add gaia test --home /Users/donglieu/script/ibc-gaia-onomy/rly
rly keys add onomy test --home /Users/donglieu/script/ibc-gaia-onomy/rly

rly paths new testing-2 testing-1 demo --home /Users/donglieu/script/ibc-gaia-onomy/rly

gaiad tx bank send val $(rly keys show gaia test --home /Users/donglieu/script/ibc-gaia-onomy/rly) 100000000000000000000000000000stake --node http://localhost:26654 --fees 200000stake -y --keyring-backend test
onomyd tx bank send val $(rly keys show onomy test --home /Users/donglieu/script/ibc-gaia-onomy/rly) 100000000000000000000000000000stake,100000000000000000000000000000anom -y --fees 200000stake --keyring-backend test --chain-id testing-1

sleep 7
rly tx clients demo --home /Users/donglieu/script/ibc-gaia-onomy/rly

sleep 7
rly tx connection demo --home /Users/donglieu/script/ibc-gaia-onomy/rly

sleep 7
rly tx channel demo --src-port transfer --dst-port transfer --order unordered --version ics20-1 --home /Users/donglieu/script/ibc-gaia-onomy/rly
