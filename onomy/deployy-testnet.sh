#!/bin/bash
set -xeu

# always returns true so set -e doesn't exit if it is not running.
killall onomyd || true
rm -rf $HOME/.onomyd/

# make four onomy directories
mkdir $HOME/.onomyd
cd $HOME/.onomyd/
mkdir $HOME/.onomyd/validator1

# init all three validators
onomyd init --chain-id=testing-1 validator1 --home=$HOME/.onomyd/validator1

# create keys for all three validators
echo $(cat /Users/donglieu/script/keys/mnemonic1)| onomyd keys add validator1 --recover --keyring-backend=test --home=$HOME/.onomyd/validator1


VALIDATOR1=$(onomyd keys show validator1 -a --keyring-backend=test --home=$HOME/.onomyd/validator1)

# create validator node with tokens to transfer to the three other nodes
onomyd genesis add-genesis-account $VALIDATOR1 10000000000000000000000000000000stake,10000000000000000000000000000000anom --home=$HOME/.onomyd/validator1

onomyd genesis gentx validator1 1000000000000000000000anom --keyring-backend=test --home=$HOME/.onomyd/validator1 --chain-id=testing-1

onomyd genesis collect-gentxs --home=$HOME/.onomyd/validator1 

# cp validator1/config/genesis.json $HOME/.onomyd/validator2/config/genesis.json
# cp validator1/config/genesis.json $HOME/.onomyd/validator3/config/genesis.json

# change app.toml values
VALIDATOR1_APP_TOML=$HOME/.onomyd/validator1/config/app.toml

# validator1
sed -i -E 's|0.0.0.0:9090|0.0.0.0:9050|g' $VALIDATOR1_APP_TOML
sed -i -E 's|minimum-gas-prices = ""|minimum-gas-prices = "0.0001stake"|g' $VALIDATOR1_APP_TOML

# change config.toml values
VALIDATOR1_CONFIG=$HOME/.onomyd/validator1/config/config.toml

# validator1
sed -i -E 's|allow_duplicate_ip = false|allow_duplicate_ip = true|g' $VALIDATOR1_CONFIG
sed -i -E 's|prometheus = false|prometheus = true|g' $VALIDATOR1_CONFIG

# # update
update_test_genesis () {
     # EX: update_test_genesis '.consensus_params["block"]["max_gas"]="100000000"'
     cat $HOME/.onomyd/validator1/config/genesis.json | jq "$1" > tmp.json && mv tmp.json $HOME/.onomyd/validator1/config/genesis.json
}

update_test_genesis '.app_state["gov"]["voting_params"]["voting_period"] = "30s"'
update_test_genesis '.app_state["mint"]["params"]["mint_denom"]= "anom"'
update_test_genesis '.app_state["gov"]["deposit_params"]["min_deposit"]=[{"denom": "anom","amount": "1000000"}]'
update_test_genesis '.app_state["crisis"]["constant_fee"]={"denom": "anom","amount": "1000"}'
update_test_genesis '.app_state["staking"]["params"]["bond_denom"]="anom"'


# copy tendermint node id of validator1 to persistent peers of validator2-3
node1=$(onomyd tendermint show-node-id --home=$HOME/.onomyd/validator1)
sed -i -E "s|persistent_peers = \"\"|persistent_peers = \"$node1@localhost:26656\"|g" $HOME/.onomyd/validator1/config/config.toml

# # start all three validators/
# onomyd start --home=$HOME/.onomyd/validator1
# screen -S onomy1 -t onomy1 -d -m 
onomyd start --home=$HOME/.onomyd/validator1