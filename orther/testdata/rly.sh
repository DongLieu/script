#!/bin/bash

rly paths new cosmoshub-4 aura_6322-2 demo --home rly

# aura1cy8jhzwu34u4k22kc84p502w2dg78uv8nlpnzv
# cosmos1z5wnemlx2qjw0aasexwylw9mrlksxfyh2rtfp7
sleep 5

gaiad tx bank send mykey --keyring-backend test --home node2 cosmos1z5wnemlx2qjw0aasexwylw9mrlksxfyh2rtfp7 10000000stake --node http://localhost:26654 --fees 200000stake -y
aurad tx bank send mykey --keyring-backend test --home node1 aura1cy8jhzwu34u4k22kc84p502w2dg78uv8nlpnzv 10000000stake --node http://localhost:26657 -y --fees 100stake

sleep 3

rly tx clients demo --home rly

sleep 7

rly tx connection demo --home rly

sleep 7

rly tx channel demo --src-port transfer --dst-port transfer --order unordered --version ics20-1 --home rly

sleep 7

screen -S relayerd -t relayerd -d -m rly start --home rly