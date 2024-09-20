onomyd tx staking create-validator \
  --amount=225000000000000000000000anom \
  --pubkey=$(onomyd tendermint show-validator --home=$HOME/.onomyd/validator1) \
  --moniker=MONIKER-YAZ \
  --chain-id=onomy-mainnet-1 \
  --commission-rate=0.05 \
  --commission-max-rate=0.10 \
  --commission-max-change-rate=0.01 \
  --min-self-delegation=225000000000000000000000 \
  --from=validator1 \
  --identity="" \
  --website="" \
  --details="" \
  --gas=500000 \
  --keyring-backend=test \
  --home=$HOME/.onomyd/validator1 \
  -y

sleep 5

onomyd tx staking create-validator \
  --amount=225000000000000000000000anom \
  --pubkey=$(onomyd tendermint show-validator --home=$HOME/.onomyd/validator2) \
  --moniker=MONIKER-YAZ \
  --chain-id=onomy-mainnet-1 \
  --commission-rate=0.05 \
  --commission-max-rate=0.10 \
  --commission-max-change-rate=0.01 \
  --min-self-delegation=225000000000000000000000 \
  --from=validator2 \
  --identity="" \
  --website="" \
  --details="" \
  --gas=500000 \
  --keyring-backend=test \
  --home=$HOME/.onomyd/validator2 \
  -y

sleep 5

onomyd tx staking create-validator \
  --amount=225000000000000000000000anom \
  --pubkey=$(onomyd tendermint show-validator --home=$HOME/.onomyd/validator3) \
  --moniker=MONIKER-YAZ \
  --chain-id=onomy-mainnet-1 \
  --commission-rate=0.05 \
  --commission-max-rate=0.10 \
  --commission-max-change-rate=0.01 \
  --min-self-delegation=225000000000000000000000 \
  --from=validator3 \
  --identity="" \
  --website="" \
  --details="" \
  --gas=500000 \
  --keyring-backend=test \
  --home=$HOME/.onomyd/validator3 \
  -y