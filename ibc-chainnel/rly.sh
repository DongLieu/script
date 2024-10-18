#!/bin/bash

rly paths new testing-2 onomy-1 demo --home /Users/donglieu/script/ibc-chainnel/rly

# onomy1lwl2wldm3hda7w05s6l6aytr3kd68gn9uae56k
# cosmos1jeqh3cy70lh29ucvglh6ts84vj6cmwgayp3cya
sleep 5

gaiad tx bank send val cosmos1jeqh3cy70lh29ucvglh6ts84vj6cmwgayp3cya 10000000stake --node http://localhost:26654 --fees 200000stake -y --keyring-backend test
onomyd tx bank send val onomy1lwl2wldm3hda7w05s6l6aytr3kd68gn9uae56k 10000000stake -y --fees 100stake --keyring-backend test

sleep 3

rly tx clients demo --home /Users/donglieu/script/ibc-chainnel/rly

sleep 7

rly tx connection demo --home /Users/donglieu/script/ibc-chainnel/rly

sleep 7

rly tx channel demo --src-port transfer --dst-port transfer --order unordered --version ics20-1 --home /Users/donglieu/script/ibc-chainnel/rly

sleep 7

screen -S relayerd -t relayerd -d -m rly start --home rly