realio-networkd tx gov submit-legacy-proposal software-upgrade v2 --upgrade-height 9249095 --upgrade-info v2  --title upgrade --description upgrade --from val1 --keyring-backend test --chain-id realionetwork_3301-1 --deposit 100000000000stake -y --no-validate  --gas 500000 --gas-prices 500ario,1000stake


realio-networkd tx gov vote 12 yes --from val1 --keyring-backend test --chain-id realionetwork_3301-1 -y --gas 500000 --gas-prices 500ario,1000stake

realio-networkd tx gov vote 12 yes --from validator4 --keyring-backend test --chain-id realionetwork_3301-1 -y --gas 500000 --gas-prices 500ario,1000stake --home=$HOME/.realio-networkd/validator4


realio-networkd tx staking delegate realiovaloper1jyrr9ga485mzdw6u7w7vcvcmhz8h6zq86p0un6 171037697574520208568450937stake --from val1 --keyring-backend test --chain-id realionetwork_3301-1 -y --gas 500000 --gas-prices 500ario,1000stake

realio-networkd tx staking delegate realiovaloper1jyrr9ga485mzdw6u7w7vcvcmhz8h6zq86p0un6 171037697574520208568450937stake --from val2 --keyring-backend test --chain-id realionetwork_3301-1 -y --gas 500000 --gas-prices 500ario,1000stake


realio-networkd tx multistaking delegate realiovaloper1jyrr9ga485mzdw6u7w7vcvcmhz8h6zq86p0un6 10000000000000000ario --from val1 --keyring-backend test --chain-id realionetwork_3301-1 -y --gas 500000 --gas-prices 500ario,1000stake


realio-networkd tx bank send val1 realio1j7qsamh9t7mynehxz2svfrpqglyeexty762dyr 17003769757652020228568450937ario,100000stake --from val1 --keyring-backend test --chain-id realionetwork_3301-1 -y --gas 500000 --gas-prices 500ario,1000stake

realio-networkd tx bank send val2 realio1j7qsamh9t7mynehxz2svfrpqglyeexty762dyr 17003769757652020228568450937ario,10000stake --from val2 --keyring-backend test --chain-id realionetwork_3301-1 -y --gas 500000 --gas-prices 500ario,1000stake

# realiovaloper1j7qsamh9t7mynehxz2svfrpqglyeexty2wfh49
realio-networkd tx multistaking create-validator \
  --amount=34000539515304040457136901874ario \
  --pubkey=$(realio-networkd tendermint show-validator --home=$HOME/.realio-networkd/validator4) \
  --moniker=MONIKER-YAZ \
  --chain-id=realionetwork_3301-1 \
  --commission-rate=0.05 \
  --commission-max-rate=0.10 \
  --commission-max-change-rate=0.01 \
  --min-self-delegation=1 \
  --from=validator4 \
  --identity="" \
  --website="" \
  --details="" \
  --gas=500000 \
  --gas-prices 500ario,1000stake \
  --keyring-backend=test \
  --home=$HOME/.realio-networkd/validator4 \
  -y