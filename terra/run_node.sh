#!/bin/bash
rm -rf $HOME/.terra/

# validate dependencies are installed
command -v jq > /dev/null 2>&1 || { echo >&2 "jq not installed. More info: https://stedolan.github.io/jq/download/"; exit 1; }
command -v toml > /dev/null 2>&1 || { echo >&2 "toml not installed. More info: https://github.com/mrijken/toml-cli"; exit 1; }

terrad keys add val --keyring-backend test --algo secp256k1
terrad keys add test1 --keyring-backend test --algo secp256k1
terrad keys add test2 --keyring-backend test --algo secp256k1
terrad keys add test3 --keyring-backend test --algo secp256k1

echo >&1 "\n"

# init chain
terrad init test-1 --chain-id testt

# Change parameter token denominations to stake
cat $HOME/.terra/config/genesis.json | jq '.app_state["staking"]["params"]["bond_denom"]="stake"' > $HOME/.terra/config/tmp_genesis.json && mv $HOME/.terra/config/tmp_genesis.json $HOME/.terra/config/genesis.json
cat $HOME/.terra/config/genesis.json | jq '.app_state["crisis"]["constant_fee"]["denom"]="stake"' > $HOME/.terra/config/tmp_genesis.json && mv $HOME/.terra/config/tmp_genesis.json $HOME/.terra/config/genesis.json
cat $HOME/.terra/config/genesis.json | jq '.app_state["gov"]["deposit_params"]["min_deposit"][0]["denom"]="stake"' > $HOME/.terra/config/tmp_genesis.json && mv $HOME/.terra/config/tmp_genesis.json $HOME/.terra/config/genesis.json
cat $HOME/.terra/config/genesis.json | jq '.app_state["mint"]["params"]["mint_denom"]="stake"' > $HOME/.terra/config/tmp_genesis.json && mv $HOME/.terra/config/tmp_genesis.json $HOME/.terra/config/genesis.json

# Set gas limit in genesis
# cat $HOME/.terra/config/genesis.json | jq '.consensus_params["block"]["max_gas"]="10000000"' > $HOME/.terra/config/tmp_genesis.json && mv $HOME/.terra/config/tmp_genesis.json $HOME/.terra/config/genesis.json

# enable rest server and swagger
toml set --toml-path $HOME/.terra/config/app.toml api.address "tcp://0.0.0.0:1350"
toml set --toml-path $HOME/.terra/config/app.toml api.swagger true
toml set --toml-path $HOME/.terra/config/app.toml api.enable true

# Allocate genesis accounts (cosmos formatted addresses)
terrad add-genesis-account val 1000000000000stake --keyring-backend test
terrad add-genesis-account test1 1000000000stake --keyring-backend test
terrad add-genesis-account test2 1000000000stake --keyring-backend test
terrad add-genesis-account test3 50000000stake --keyring-backend test

# Sign genesis transaction
terrad gentx val 1000000stake --keyring-backend test --chain-id testt

# Collect genesis tx
terrad collect-gentxs

# Run this to ensure everything worked and that the genesis file is setup correctly
terrad validate-genesis

# Start the node (remove the --pruning=nothing flag if historical queries are not needed)
terrad start 

# sleep 7

# terrad q bank balances $(terrad keys show val -a --keyring-backend=test)

# terrad keys add newkey --keyring-backend test --algo secp256k1
# terrad keys list --keyring-backend test

# terrad tx bank send $(terrad keys show val -a --keyring-backend=test) $(terrad keys show newkey -a --keyring-backend=test) 1000stake --keyring-backend=test --chain-id terra-test-a -y
# terrad tx bank send $(terrad keys show val -a --keyring-backend=test) $(terrad keys show newkey -a --keyring-backend=test) 1luna --keyring-backend=test --chain-id terra-test-a -y

# sleep 7
# terrad keys add newkey --keyring-backend test --algo secp256k1
# terrad q bank balances $(terrad keys show newkey -a --keyring-backend=test)
# terrad q bank balances $(terrad keys show val -a --keyring-backend=test)
# terrad tx bank send $(terrad keys show val -a --keyring-backend=test) $(terrad keys show newkey -a --keyring-backend=test) 1000juno --keyring-backend=test --chain-id terra-test-a -y


terrad tx wasm store /Users/donglieu/253/rust-counter/artifacts/counter-aarch64.wasm --keyring-backend=test --chain-id testt --from val --gas 996208 -y


terrad tx wasm instantiate 1 '{"count": "0"}' --label "counter" --keyring-backend=test --chain-id testt --from val --gas 996208 -y --admin terra17vn2hm5agm8tt9h8yvtmt2gvems6wk6y97drh4

terrad query wasm contract-state smart terra14hj2tavq8fpesdwxxcu44rty3hh90vhujrvcmstl4zr3txmfvw9ssrc8au '{"get_count":{}}'
terrad query wasm contract-state smart terra14hj2tavq8fpesdwxxcu44rty3hh90vhujrvcmstl4zr3txmfvw9ssrc8au '{"get_total_funds":{}}'


terrad tx wasm execute terra14hj2tavq8fpesdwxxcu44rty3hh90vhujrvcmstl4zr3txmfvw9ssrc8au '{"increment":{}}' --amount 1000stake --from val --keyring-backend=test --chain-id testt --gas 996208 -y



terrad query wasm contract-state smart terra14hj2tavq8fpesdwxxcu44rty3hh90vhujrvcmstl4zr3txmfvw9ssrc8au '{"get_count":{}}'
terrad query wasm contract-state smart terra14hj2tavq8fpesdwxxcu44rty3hh90vhujrvcmstl4zr3txmfvw9ssrc8au '{"get_total_funds":{}}'