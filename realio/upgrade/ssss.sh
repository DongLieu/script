realio-networkd tx gov submit-legacy-proposal software-upgrade v2 --upgrade-height 9249153 --upgrade-info v2  --title upgrade --description upgrade --from val1 --keyring-backend test --chain-id realionetwork_3301-1 --deposit 100000000000stake -y --no-validate  --gas 500000 --gas-prices 500ario,1000stake

realio-networkd tx gov vote 12 yes --from val1 --keyring-backend test --chain-id realionetwork_3301-1 -y --gas 500000 --gas-prices 500ario,1000stake


realio-networkd tx staking delegate realiovaloper1jyrr9ga485mzdw6u7w7vcvcmhz8h6zq86p0un6 171037697574520208568450937stake --from val1 --keyring-backend test --chain-id realionetwork_3301-1 -y --gas 500000 --gas-prices 500ario,1000stake

realio-networkd tx staking delegate realiovaloper1jyrr9ga485mzdw6u7w7vcvcmhz8h6zq86p0un6 171037697574520208568450937stake --from val2 --keyring-backend test --chain-id realionetwork_3301-1 -y --gas 500000 --gas-prices 500ario,1000stake


realio-networkd tx multistaking delegate realiovaloper1jyrr9ga485mzdw6u7w7vcvcmhz8h6zq86p0un6 10000000000000000ario --from val1 --keyring-backend test --chain-id realionetwork_3301-1 -y --gas 500000 --gas-prices 500ario,1000stake