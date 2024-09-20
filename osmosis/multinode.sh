#!/bin/bash
set -xeu

# always returns true so set -e doesn't exit if it is not running.
killall osmosisd || true
rm -rf $HOME/.osmosisd/

# make four osmo directories
mkdir $HOME/.osmosisd
cd $HOME/.osmosisd/
mkdir $HOME/.osmosisd/validator1
mkdir $HOME/.osmosisd/validator2
mkdir $HOME/.osmosisd/validator3

# init all three validators
osmosisd init --chain-id=testing-1 validator1 --home=$HOME/.osmosisd/validator1
osmosisd init --chain-id=testing-1 validator2 --home=$HOME/.osmosisd/validator2
osmosisd init --chain-id=testing-1 validator3 --home=$HOME/.osmosisd/validator3

# create keys for all three validators
# osmo1f7twgcq4ypzg7y24wuywy06xmdet8pc4a9zm9j
echo $(cat /Users/donglieu/script/keys/mnemonic1)| osmosisd keys add validator1 --recover --keyring-backend=test --home=$HOME/.osmosisd/validator1
# osmo1w7f3xx7e75p4l7qdym5msqem9rd4dyc4k0eqh6
echo $(cat /Users/donglieu/script/keys/mnemonic2)| osmosisd keys add validator2 --recover --keyring-backend=test --home=$HOME/.osmosisd/validator2
# osmo1g9v3zjt6rfkwm4s8sw9wu4jgz9me8pn2kj5rj2
echo $(cat /Users/donglieu/script/keys/mnemonic3)| osmosisd keys add validator3 --recover --keyring-backend=test --home=$HOME/.osmosisd/validator3

# create validator node with tokens to transfer to the three other nodes
osmosisd  add-genesis-account $(osmosisd keys show validator1 -a --keyring-backend=test --home=$HOME/.osmosisd/validator1) 10000000000000000000000000000000stake,10000000000000000000000000000000osmo --home=$HOME/.osmosisd/validator1 
osmosisd  add-genesis-account $(osmosisd keys show validator2 -a --keyring-backend=test --home=$HOME/.osmosisd/validator2) 10000000000000000000000000000000stake,10000000000000000000000000000000osmo --home=$HOME/.osmosisd/validator1 
osmosisd  add-genesis-account $(osmosisd keys show validator3 -a --keyring-backend=test --home=$HOME/.osmosisd/validator3) 10000000000000000000000000000000stake,10000000000000000000000000000000osmo --home=$HOME/.osmosisd/validator1
osmosisd  add-genesis-account $(osmosisd keys show validator1 -a --keyring-backend=test --home=$HOME/.osmosisd/validator1) 10000000000000000000000000000000stake,10000000000000000000000000000000osmo --home=$HOME/.osmosisd/validator2
osmosisd  add-genesis-account $(osmosisd keys show validator2 -a --keyring-backend=test --home=$HOME/.osmosisd/validator2) 10000000000000000000000000000000stake,10000000000000000000000000000000osmo --home=$HOME/.osmosisd/validator2 
osmosisd  add-genesis-account $(osmosisd keys show validator3 -a --keyring-backend=test --home=$HOME/.osmosisd/validator3) 10000000000000000000000000000000stake,10000000000000000000000000000000osmo --home=$HOME/.osmosisd/validator2 
osmosisd  add-genesis-account $(osmosisd keys show validator1 -a --keyring-backend=test --home=$HOME/.osmosisd/validator1) 10000000000000000000000000000000stake,10000000000000000000000000000000osmo --home=$HOME/.osmosisd/validator3 
osmosisd  add-genesis-account $(osmosisd keys show validator2 -a --keyring-backend=test --home=$HOME/.osmosisd/validator2) 10000000000000000000000000000000stake,10000000000000000000000000000000osmo --home=$HOME/.osmosisd/validator3 
osmosisd  add-genesis-account $(osmosisd keys show validator3 -a --keyring-backend=test --home=$HOME/.osmosisd/validator3) 10000000000000000000000000000000stake,10000000000000000000000000000000osmo --home=$HOME/.osmosisd/validator3
osmosisd  gentx validator1 1000000000000000000000stake --keyring-backend=test --home=$HOME/.osmosisd/validator1 --chain-id=testing-1
osmosisd  gentx validator2 1000000000000000000000stake --keyring-backend=test --home=$HOME/.osmosisd/validator2 --chain-id=testing-1
osmosisd  gentx validator3 1000000000000000000000stake --keyring-backend=test --home=$HOME/.osmosisd/validator3 --chain-id=testing-1

cp validator2/config/gentx/*.json $HOME/.osmosisd/validator1/config/gentx/
cp validator3/config/gentx/*.json $HOME/.osmosisd/validator1/config/gentx/
osmosisd  collect-gentxs --home=$HOME/.osmosisd/validator1 
osmosisd  collect-gentxs --home=$HOME/.osmosisd/validator2
osmosisd  collect-gentxs --home=$HOME/.osmosisd/validator3 

cp validator1/config/genesis.json $HOME/.osmosisd/validator2/config/genesis.json
cp validator1/config/genesis.json $HOME/.osmosisd/validator3/config/genesis.json


# change app.toml values
VALIDATOR1_APP_TOML=$HOME/.osmosisd/validator1/config/app.toml
VALIDATOR2_APP_TOML=$HOME/.osmosisd/validator2/config/app.toml
VALIDATOR3_APP_TOML=$HOME/.osmosisd/validator3/config/app.toml

# validator1
sed -i -E 's|localhost:9090|localhost:9050|g' $VALIDATOR1_APP_TOML

# validator2
sed -i -E 's|tcp://localhost:1317|tcp://localhost:1316|g' $VALIDATOR2_APP_TOML
# sed -i -E 's|0.0.0.0:9090|0.0.0.0:9088|g' $VALIDATOR2_APP_TOML
sed -i -E 's|localhost:9090|localhost:9088|g' $VALIDATOR2_APP_TOML
# sed -i -E 's|0.0.0.0:9091|0.0.0.0:9089|g' $VALIDATOR2_APP_TOML
sed -i -E 's|localhost:9091|localhost:9089|g' $VALIDATOR2_APP_TOML
sed -i -E 's|tcp://0.0.0.0:10337|tcp://0.0.0.0:10347|g' $VALIDATOR2_APP_TOML

# validator3
sed -i -E 's|tcp://localhost:1317|tcp://localhost:1315|g' $VALIDATOR3_APP_TOML
# sed -i -E 's|0.0.0.0:9090|0.0.0.0:9086|g' $VALIDATOR3_APP_TOML
sed -i -E 's|localhost:9090|localhost:9086|g' $VALIDATOR3_APP_TOML
# sed -i -E 's|0.0.0.0:9091|0.0.0.0:9087|g' $VALIDATOR3_APP_TOML
sed -i -E 's|localhost:9091|localhost:9087|g' $VALIDATOR3_APP_TOML
sed -i -E 's|tcp://0.0.0.0:10337|tcp://0.0.0.0:10357|g' $VALIDATOR3_APP_TOML

# change config.toml values
VALIDATOR1_CONFIG=$HOME/.osmosisd/validator1/config/config.toml
VALIDATOR2_CONFIG=$HOME/.osmosisd/validator2/config/config.toml
VALIDATOR3_CONFIG=$HOME/.osmosisd/validator3/config/config.toml


# validator1
sed -i -E 's|allow_duplicate_ip = false|allow_duplicate_ip = true|g' $VALIDATOR1_CONFIG
# sed -i -E 's|prometheus = false|prometheus = true|g' $VALIDATOR1_CONFIG


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
#     cat $HOME/.osmosisd/validator1/config/genesis.json | jq "$1" > tmp.json && mv tmp.json $HOME/.osmosisd/validator1/config/genesis.json
#     cat $HOME/.osmosisd/validator2/config/genesis.json | jq "$1" > tmp.json && mv tmp.json $HOME/.osmosisd/validator2/config/genesis.json
#     cat $HOME/.osmosisd/validator3/config/genesis.json | jq "$1" > tmp.json && mv tmp.json $HOME/.osmosisd/validator3/config/genesis.json
# }

# update_test_genesis '.app_state["gov"]["voting_params"]["voting_period"] = "30s"'
# update_test_genesis '.app_state["mint"]["params"]["mint_denom"]= "stake"'
# update_test_genesis '.app_state["gov"]["deposit_params"]["min_deposit"]=[{"denom": "stake","amount": "1000000"}]'
# update_test_genesis '.app_state["crisis"]["constant_fee"]={"denom": "stake","amount": "1000"}'
# update_test_genesis '.app_state["staking"]["params"]["bond_denom"]="stake"'


# copy validator1 genesis file to validator2-3
cp $HOME/.osmosisd/validator1/config/genesis.json $HOME/.osmosisd/validator2/config/genesis.json
cp $HOME/.osmosisd/validator1/config/genesis.json $HOME/.osmosisd/validator3/config/genesis.json

# copy tendermint node id of validator1 to persistent peers of validator2-3
node1=$(osmosisd tendermint show-node-id --home=$HOME/.osmosisd/validator1)
node2=$(osmosisd tendermint show-node-id --home=$HOME/.osmosisd/validator2)
node3=$(osmosisd tendermint show-node-id --home=$HOME/.osmosisd/validator3)
sed -i -E "s|persistent_peers = \"\"|persistent_peers = \"$node1@localhost:26656,$node2@localhost:26653,$node3@localhost:26650\"|g" $HOME/.osmosisd/validator1/config/config.toml
sed -i -E "s|persistent_peers = \"\"|persistent_peers = \"$node1@localhost:26656,$node2@localhost:26653,$node3@localhost:26650\"|g" $HOME/.osmosisd/validator2/config/config.toml
sed -i -E "s|persistent_peers = \"\"|persistent_peers = \"$node1@localhost:26656,$node2@localhost:26653,$node3@localhost:26650\"|g" $HOME/.osmosisd/validator3/config/config.toml


# # start all three validators/
# osmosisd start --home=$HOME/.osmosisd/validator1
screen -S osmo1 -t osmo1 -d -m osmosisd start --home=$HOME/.osmosisd/validator1
screen -S osmo2 -t osmo2 -d -m osmosisd start --home=$HOME/.osmosisd/validator2
screen -S osmo3 -t osmo3 -d -m osmosisd start --home=$HOME/.osmosisd/validator3
# osmosisd start --home=$HOME/.osmosisd/validator3

# screen -r osmo1

sleep 7

# osmosisd tx bank send $(osmosisd keys show validator1 -a --keyring-backend=test --home=$HOME/.osmosisd/validator1) $(osmosisd keys show validator2 -a --keyring-backend=test --home=$HOME/.osmosisd/validator2) 100000stake --keyring-backend=test --chain-id=testing-1 -y --home=$HOME/.osmosisd/validator1 --fees 10stake

# sleep 7
# osmo1f7twgcq4ypzg7y24wuywy06xmdet8pc4a9zm9j
# osmo1w7f3xx7e75p4l7qdym5msqem9rd4dyc4k0eqh6
# osmo1g9v3zjt6rfkwm4s8sw9wu4jgz9me8pn2kj5rj2
# osmo1qvuhm5m644660nd8377d6l7yz9e9hhm93hgk85

osmosisd tx bank send osmo1f7twgcq4ypzg7y24wuywy06xmdet8pc4a9zm9j osmo1qvuhm5m644660nd8377d6l7yz9e9hhm93hgk85 10000000000000000000000stake --keyring-backend=test --chain-id=testing-1 -y --home=$HOME/.osmosisd/validator1 --fees 500stake
# sleep 7
# osmosisd tx bank send osmo1f7twgcq4ypzg7y24wuywy06xmdet8pc4hhtf9t osmo16gjg8p5fedy48wf403jwmz2cxlwqtkqlwe0lug 10000000000000000000000stake --keyring-backend=test --chain-id=testing-1 -y --home=$HOME/.osmosisd/validator1 --fees 10stake

