#!/bin/bash
rm -rf /Users/donglieu/script/ibc-gaia-terra/rly
mkdir /Users/donglieu/script/ibc-gaia-terra/rly

rly config init --home /Users/donglieu/script/ibc-gaia-terra/rly


cp /Users/donglieu/script/ibc-gaia-terra/config.yaml /Users/donglieu/script/ibc-gaia-terra/rly/config/config.yaml
# edit config.yam
# add keys
rly keys add gaia test --home /Users/donglieu/script/ibc-gaia-terra/rly
rly keys add terra test --home /Users/donglieu/script/ibc-gaia-terra/rly

rly paths new testing-2 testing-1 demo --home /Users/donglieu/script/ibc-gaia-terra/rly

gaiad tx bank send val $(rly keys show gaia test --home /Users/donglieu/script/ibc-gaia-terra/rly) 10000000stake --node http://localhost:26654 --fees 200000stake -y --keyring-backend test
terrad tx bank send val $(rly keys show terra test --home /Users/donglieu/script/ibc-gaia-terra/rly) 10000000stake -y --fees 100stake --keyring-backend test --chain-id testing-1

sleep 7
rly tx clients demo --home /Users/donglieu/script/ibc-gaia-terra/rly

sleep 7
rly tx connection demo --home /Users/donglieu/script/ibc-gaia-terra/rly

sleep 7
rly tx channel demo --src-port transfer --dst-port transfer --order unordered --version ics20-1 --home /Users/donglieu/script/ibc-gaia-terra/rly
