#!/bin/bash
set -xeu

# always returns true so set -e doesn't exit if it is not running.
killall injectived || true
rm -rf $HOME/.injectived/

# make four injective directories
mkdir $HOME/.injectived
cd $HOME/.injectived/
mkdir $HOME/.injectived/validator1
mkdir $HOME/.injectived/validator2
mkdir $HOME/.injectived/validator3

# init all three validators
injectived init --chain-id=testing-1 validator1 --home=$HOME/.injectived/validator1
injectived init --chain-id=testing-1 validator2 --home=$HOME/.injectived/validator2
injectived init --chain-id=testing-1 validator3 --home=$HOME/.injectived/validator3

# create keys for all three validators
injectived keys add validator1 --keyring-backend=test --home=$HOME/.injectived/validator1
injectived keys add validator2 --keyring-backend=test --home=$HOME/.injectived/validator2
injectived keys add validator3 --keyring-backend=test --home=$HOME/.injectived/validator3

# create validator node with tokens to transfer to the three other nodes
injectived add-genesis-account $(injectived keys show validator1 -a --keyring-backend=test --home=$HOME/.injectived/validator1) 10000000000000000000000000000000stake,10000000000000000000000000000000inj --home=$HOME/.injectived/validator1 --chain-id=testing-1
injectived add-genesis-account $(injectived keys show validator2 -a --keyring-backend=test --home=$HOME/.injectived/validator2) 10000000000000000000000000000000stake,10000000000000000000000000000000inj --home=$HOME/.injectived/validator1 --chain-id=testing-1
injectived add-genesis-account $(injectived keys show validator3 -a --keyring-backend=test --home=$HOME/.injectived/validator3) 10000000000000000000000000000000stake,10000000000000000000000000000000inj --home=$HOME/.injectived/validator1 --chain-id=testing-1
injectived add-genesis-account $(injectived keys show validator1 -a --keyring-backend=test --home=$HOME/.injectived/validator1) 10000000000000000000000000000000stake,10000000000000000000000000000000inj --home=$HOME/.injectived/validator2 --chain-id=testing-1
injectived add-genesis-account $(injectived keys show validator2 -a --keyring-backend=test --home=$HOME/.injectived/validator2) 10000000000000000000000000000000stake,10000000000000000000000000000000inj --home=$HOME/.injectived/validator2 --chain-id=testing-1
injectived add-genesis-account $(injectived keys show validator3 -a --keyring-backend=test --home=$HOME/.injectived/validator3) 10000000000000000000000000000000stake,10000000000000000000000000000000inj --home=$HOME/.injectived/validator2 --chain-id=testing-1
injectived add-genesis-account $(injectived keys show validator1 -a --keyring-backend=test --home=$HOME/.injectived/validator1) 10000000000000000000000000000000stake,10000000000000000000000000000000inj --home=$HOME/.injectived/validator3 --chain-id=testing-1
injectived add-genesis-account $(injectived keys show validator2 -a --keyring-backend=test --home=$HOME/.injectived/validator2) 10000000000000000000000000000000stake,10000000000000000000000000000000inj --home=$HOME/.injectived/validator3 --chain-id=testing-1
injectived add-genesis-account $(injectived keys show validator3 -a --keyring-backend=test --home=$HOME/.injectived/validator3) 10000000000000000000000000000000stake,10000000000000000000000000000000inj --home=$HOME/.injectived/validator3 --chain-id=testing-1
injectived gentx validator1 1000000000000000000000stake --keyring-backend=test --home=$HOME/.injectived/validator1 --chain-id=testing-1
injectived gentx validator2 1000000000000000000000stake --keyring-backend=test --home=$HOME/.injectived/validator2 --chain-id=testing-1
injectived gentx validator3 1000000000000000000000stake --keyring-backend=test --home=$HOME/.injectived/validator3 --chain-id=testing-1

cp validator2/config/gentx/*.json $HOME/.injectived/validator1/config/gentx/
cp validator3/config/gentx/*.json $HOME/.injectived/validator1/config/gentx/
injectived collect-gentxs --home=$HOME/.injectived/validator1 

# cp validator1/config/genesis.json $HOME/.injectived/validator2/config/genesis.json
# cp validator1/config/genesis.json $HOME/.injectived/validator3/config/genesis.json


# change app.toml values
VALIDATOR1_APP_TOML=$HOME/.injectived/validator1/config/app.toml
VALIDATOR2_APP_TOML=$HOME/.injectived/validator2/config/app.toml
VALIDATOR3_APP_TOML=$HOME/.injectived/validator3/config/app.toml

# validator1
sed -i -E 's|0.0.0.0:9090|0.0.0.0:9050|g' $VALIDATOR1_APP_TOML

# validator2
sed -i -E 's|tcp://localhost:1317|tcp://localhost:1316|g' $VALIDATOR2_APP_TOML
sed -i -E 's|0.0.0.0:9090|0.0.0.0:9088|g' $VALIDATOR2_APP_TOML
# sed -i -E 's|localhost:9090|localhost:9088|g' $VALIDATOR2_APP_TOML
sed -i -E 's|0.0.0.0:9091|0.0.0.0:9089|g' $VALIDATOR2_APP_TOML
# sed -i -E 's|localhost:9091|localhost:9089|g' $VALIDATOR2_APP_TOML
sed -i -E 's|tcp://0.0.0.0:10337|tcp://0.0.0.0:10347|g' $VALIDATOR2_APP_TOML

# validator3
sed -i -E 's|tcp://localhost:1317|tcp://localhost:1315|g' $VALIDATOR3_APP_TOML
sed -i -E 's|0.0.0.0:9090|0.0.0.0:9086|g' $VALIDATOR3_APP_TOML
# sed -i -E 's|localhost:9090|localhost:9086|g' $VALIDATOR3_APP_TOML
sed -i -E 's|0.0.0.0:9091|0.0.0.0:9087|g' $VALIDATOR3_APP_TOML
# sed -i -E 's|localhost:9091|localhost:9087|g' $VALIDATOR3_APP_TOML
sed -i -E 's|tcp://0.0.0.0:10337|tcp://0.0.0.0:10357|g' $VALIDATOR3_APP_TOML

# change config.toml values
VALIDATOR1_CONFIG=$HOME/.injectived/validator1/config/config.toml
VALIDATOR2_CONFIG=$HOME/.injectived/validator2/config/config.toml
VALIDATOR3_CONFIG=$HOME/.injectived/validator3/config/config.toml


# validator1
sed -i -E 's|allow_duplicate_ip = false|allow_duplicate_ip = true|g' $VALIDATOR1_CONFIG
sed -i -E 's|prometheus = false|prometheus = true|g' $VALIDATOR1_CONFIG


# validator2
sed -i -E 's|tcp://127.0.0.1:26658|tcp://127.0.0.1:26655|g' $VALIDATOR2_CONFIG
sed -i -E 's|tcp://127.0.0.1:26657|tcp://127.0.0.1:26654|g' $VALIDATOR2_CONFIG
sed -i -E 's|tcp://0.0.0.0:26656|tcp://0.0.0.0:26653|g' $VALIDATOR2_CONFIG
sed -i -E 's|allow_duplicate_ip = false|allow_duplicate_ip = true|g' $VALIDATOR2_CONFIG
sed -i -E 's|prometheus = false|prometheus = true|g' $VALIDATOR2_CONFIG
sed -i -E 's|prometheus_listen_addr = ":26660"|prometheus_listen_addr = ":26630"|g' $VALIDATOR2_CONFIG

# validator3
sed -i -E 's|tcp://127.0.0.1:26658|tcp://127.0.0.1:26652|g' $VALIDATOR3_CONFIG
sed -i -E 's|tcp://127.0.0.1:26657|tcp://127.0.0.1:26651|g' $VALIDATOR3_CONFIG
sed -i -E 's|tcp://0.0.0.0:26656|tcp://0.0.0.0:26650|g' $VALIDATOR3_CONFIG
sed -i -E 's|allow_duplicate_ip = false|allow_duplicate_ip = true|g' $VALIDATOR3_CONFIG
sed -i -E 's|prometheus = false|prometheus = true|g' $VALIDATOR3_CONFIG
sed -i -E 's|prometheus_listen_addr = ":26660"|prometheus_listen_addr = ":26620"|g' $VALIDATOR3_CONFIG

# # update
# update_test_genesis () {
#     # EX: update_test_genesis '.consensus_params["block"]["max_gas"]="100000000"'
#     cat $HOME/.injectived/validator1/config/genesis.json | jq "$1" > tmp.json && mv tmp.json $HOME/.injectived/validator1/config/genesis.json
#     cat $HOME/.injectived/validator2/config/genesis.json | jq "$1" > tmp.json && mv tmp.json $HOME/.injectived/validator2/config/genesis.json
#     cat $HOME/.injectived/validator3/config/genesis.json | jq "$1" > tmp.json && mv tmp.json $HOME/.injectived/validator3/config/genesis.json
# }

# update_test_genesis '.app_state["gov"]["voting_params"]["voting_period"] = "30s"'
# update_test_genesis '.app_state["mint"]["params"]["mint_denom"]= "stake"'
# update_test_genesis '.app_state["gov"]["deposit_params"]["min_deposit"]=[{"denom": "stake","amount": "1000000"}]'
# update_test_genesis '.app_state["crisis"]["constant_fee"]={"denom": "stake","amount": "1000"}'
# update_test_genesis '.app_state["staking"]["params"]["bond_denom"]="stake"'


# copy validator1 genesis file to validator2-3
cp $HOME/.injectived/validator1/config/genesis.json $HOME/.injectived/validator2/config/genesis.json
cp $HOME/.injectived/validator1/config/genesis.json $HOME/.injectived/validator3/config/genesis.json

# copy tendermint node id of validator1 to persistent peers of validator2-3
node1=$(injectived tendermint show-node-id --home=$HOME/.injectived/validator1)
node2=$(injectived tendermint show-node-id --home=$HOME/.injectived/validator2)
node3=$(injectived tendermint show-node-id --home=$HOME/.injectived/validator3)
sed -i -E "s|persistent_peers = \"\"|persistent_peers = \"$node1@localhost:26656,$node2@localhost:26656,$node3@localhost:26656\"|g" $HOME/.injectived/validator1/config/config.toml
sed -i -E "s|persistent_peers = \"\"|persistent_peers = \"$node1@localhost:26656,$node2@localhost:26656,$node3@localhost:26656\"|g" $HOME/.injectived/validator2/config/config.toml
sed -i -E "s|persistent_peers = \"\"|persistent_peers = \"$node1@localhost:26656,$node2@localhost:26656,$node3@localhost:26656\"|g" $HOME/.injectived/validator3/config/config.toml


# # start all three validators/
# injectived start --home=$HOME/.injectived/validator1
screen -S injective1 -t injective1 -d -m injectived start --home=$HOME/.injectived/validator1
screen -S injective2 -t injective2 -d -m injectived start --home=$HOME/.injectived/validator2
screen -S injective3 -t injective3 -d -m injectived start --home=$HOME/.injectived/validator3
# injectived start --home=$HOME/.injectived/validator3

# screen -r injective1

sleep 7

injectived tx bank send $(injectived keys show validator1 -a --keyring-backend=test --home=$HOME/.injectived/validator1) $(injectived keys show validator2 -a --keyring-backend=test --home=$HOME/.injectived/validator2) 100000stake --keyring-backend=test --chain-id=testing-1 -y --home=$HOME/.injectived/validator1 --fees 100000000000000inj

# injectived tx gov submit-proposal  /Users/donglieu/Desktop/scrip/injective/propasal.json --timeout-height 10000 --from validator1  --keyring-backend=test --chain-id=testing-1 -y --home=$HOME/.injectived/validator1 --fees 100000000000000inj

# injectived tx gov submit-proposal  /Users/donglieu/Desktop/scrip/injective/propasal1.json --timeout-height 10000 --from validator1  --keyring-backend=test --chain-id=testing-1 -y --home=$HOME/.injectived/validator1 --fees 100000000000000inj


# injectived tx gov vote 1 yes --from validator2 --keyring-backend=test --chain-id=testing-1 -y --home=$HOME/.injectived/validator2 --fees 100000000000000inj

# injectived q gov proposals --from validator2 --keyring-backend=test --chain-id=testing-1 -y --home=$HOME/.injectived/validator2 


# injectived tx gov submit-legacy-proposal --title="Test Proposal" --description="testing" --type="Text" --deposit="100000000stake" --from validator1  --keyring-backend=test --chain-id=testing-1 -y --home=$HOME/.injectived/validator1 --fees 100000000000000inj