#!/bin/bash
set -xeu

# always returns true so set -e doesn't exit if it is not running.
killall gaiad || true
rm -rf $HOME/.gaiad/

# make four gaia directories
mkdir $HOME/.gaiad
cd $HOME/.gaiad/
mkdir $HOME/.gaiad/validator1
mkdir $HOME/.gaiad/validator2
mkdir $HOME/.gaiad/validator3

# init all three validators
gaiad init --chain-id=testing-1 validator1 --home=$HOME/.gaiad/validator1
gaiad init --chain-id=testing-1 validator2 --home=$HOME/.gaiad/validator2
gaiad init --chain-id=testing-1 validator3 --home=$HOME/.gaiad/validator3

# create keys for all three validators
# cosmos1f7twgcq4ypzg7y24wuywy06xmdet8pc4473tnq
echo $(cat /Users/donglieu/script/keys/mnemonic1)| gaiad keys add validator1 --recover --keyring-backend=test --home=$HOME/.gaiad/validator1
# cosmos1w7f3xx7e75p4l7qdym5msqem9rd4dyc4752spg
echo $(cat /Users/donglieu/script/keys/mnemonic2)| gaiad keys add validator2 --recover --keyring-backend=test --home=$HOME/.gaiad/validator2
# cosmos1g9v3zjt6rfkwm4s8sw9wu4jgz9me8pn27f8nyc
echo $(cat /Users/donglieu/script/keys/mnemonic3)| gaiad keys add validator3 --recover --keyring-backend=test --home=$HOME/.gaiad/validator3

# create validator node with tokens to transfer to the three other nodes
gaiad genesis add-genesis-account $(gaiad keys show validator1 -a --keyring-backend=test --home=$HOME/.gaiad/validator1) 10000000000000000000000000000000stake,10000000000000000000000000000000gaia --home=$HOME/.gaiad/validator1 
gaiad genesis add-genesis-account $(gaiad keys show validator2 -a --keyring-backend=test --home=$HOME/.gaiad/validator2) 10000000000000000000000000000000stake,10000000000000000000000000000000gaia --home=$HOME/.gaiad/validator1 
gaiad genesis add-genesis-account $(gaiad keys show validator3 -a --keyring-backend=test --home=$HOME/.gaiad/validator3) 10000000000000000000000000000000stake,10000000000000000000000000000000gaia --home=$HOME/.gaiad/validator1
gaiad genesis add-genesis-account $(gaiad keys show validator1 -a --keyring-backend=test --home=$HOME/.gaiad/validator1) 10000000000000000000000000000000stake,10000000000000000000000000000000gaia --home=$HOME/.gaiad/validator2
gaiad genesis add-genesis-account $(gaiad keys show validator2 -a --keyring-backend=test --home=$HOME/.gaiad/validator2) 10000000000000000000000000000000stake,10000000000000000000000000000000gaia --home=$HOME/.gaiad/validator2 
gaiad genesis add-genesis-account $(gaiad keys show validator3 -a --keyring-backend=test --home=$HOME/.gaiad/validator3) 10000000000000000000000000000000stake,10000000000000000000000000000000gaia --home=$HOME/.gaiad/validator2 
gaiad genesis add-genesis-account $(gaiad keys show validator1 -a --keyring-backend=test --home=$HOME/.gaiad/validator1) 10000000000000000000000000000000stake,10000000000000000000000000000000gaia --home=$HOME/.gaiad/validator3 
gaiad genesis add-genesis-account $(gaiad keys show validator2 -a --keyring-backend=test --home=$HOME/.gaiad/validator2) 10000000000000000000000000000000stake,10000000000000000000000000000000gaia --home=$HOME/.gaiad/validator3 
gaiad genesis add-genesis-account $(gaiad keys show validator3 -a --keyring-backend=test --home=$HOME/.gaiad/validator3) 10000000000000000000000000000000stake,10000000000000000000000000000000gaia --home=$HOME/.gaiad/validator3
gaiad genesis gentx validator1 1000000000000000000000stake --keyring-backend=test --home=$HOME/.gaiad/validator1 --chain-id=testing-1
gaiad genesis gentx validator2 1000000000000000000000stake --keyring-backend=test --home=$HOME/.gaiad/validator2 --chain-id=testing-1
gaiad genesis gentx validator3 1000000000000000000000stake --keyring-backend=test --home=$HOME/.gaiad/validator3 --chain-id=testing-1

cp validator2/config/gentx/*.json $HOME/.gaiad/validator1/config/gentx/
cp validator3/config/gentx/*.json $HOME/.gaiad/validator1/config/gentx/
gaiad genesis collect-gentxs --home=$HOME/.gaiad/validator1 
gaiad genesis collect-gentxs --home=$HOME/.gaiad/validator2
gaiad genesis collect-gentxs --home=$HOME/.gaiad/validator3 

cp validator1/config/genesis.json $HOME/.gaiad/validator2/config/genesis.json
cp validator1/config/genesis.json $HOME/.gaiad/validator3/config/genesis.json


# change app.toml values
VALIDATOR1_APP_TOML=$HOME/.gaiad/validator1/config/app.toml
VALIDATOR2_APP_TOML=$HOME/.gaiad/validator2/config/app.toml
VALIDATOR3_APP_TOML=$HOME/.gaiad/validator3/config/app.toml

# validator1
sed -i -E 's|localhost:9090|localhost:9050|g' $VALIDATOR1_APP_TOML
sed -i -E 's|minimum-gas-prices = ""|minimum-gas-prices = "0.0001stake"|g' $VALIDATOR1_APP_TOML

# validator2
sed -i -E 's|tcp://localhost:1317|tcp://localhost:1316|g' $VALIDATOR2_APP_TOML
# sed -i -E 's|0.0.0.0:9090|0.0.0.0:9088|g' $VALIDATOR2_APP_TOML
sed -i -E 's|localhost:9090|localhost:9088|g' $VALIDATOR2_APP_TOML
# sed -i -E 's|0.0.0.0:9091|0.0.0.0:9089|g' $VALIDATOR2_APP_TOML
sed -i -E 's|localhost:9091|localhost:9089|g' $VALIDATOR2_APP_TOML
sed -i -E 's|minimum-gas-prices = ""|minimum-gas-prices = "0.0001stake"|g' $VALIDATOR2_APP_TOML

# validator3
sed -i -E 's|tcp://localhost:1317|tcp://localhost:1315|g' $VALIDATOR3_APP_TOML
# sed -i -E 's|0.0.0.0:9090|0.0.0.0:9086|g' $VALIDATOR3_APP_TOML
sed -i -E 's|localhost:9090|localhost:9086|g' $VALIDATOR3_APP_TOML
# sed -i -E 's|0.0.0.0:9091|0.0.0.0:9087|g' $VALIDATOR3_APP_TOML
sed -i -E 's|localhost:9091|localhost:9087|g' $VALIDATOR3_APP_TOML
sed -i -E 's|minimum-gas-prices = ""|minimum-gas-prices = "0.0001stake"|g' $VALIDATOR3_APP_TOML

# change config.toml values
VALIDATOR1_CONFIG=$HOME/.gaiad/validator1/config/config.toml
VALIDATOR2_CONFIG=$HOME/.gaiad/validator2/config/config.toml
VALIDATOR3_CONFIG=$HOME/.gaiad/validator3/config/config.toml


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
#     cat $HOME/.gaiad/validator1/config/genesis.json | jq "$1" > tmp.json && mv tmp.json $HOME/.gaiad/validator1/config/genesis.json
#     cat $HOME/.gaiad/validator2/config/genesis.json | jq "$1" > tmp.json && mv tmp.json $HOME/.gaiad/validator2/config/genesis.json
#     cat $HOME/.gaiad/validator3/config/genesis.json | jq "$1" > tmp.json && mv tmp.json $HOME/.gaiad/validator3/config/genesis.json
# }

# update_test_genesis '.app_state["gov"]["voting_params"]["voting_period"] = "30s"'
# update_test_genesis '.app_state["mint"]["params"]["mint_denom"]= "stake"'
# update_test_genesis '.app_state["gov"]["deposit_params"]["min_deposit"]=[{"denom": "stake","amount": "1000000"}]'
# update_test_genesis '.app_state["crisis"]["constant_fee"]={"denom": "stake","amount": "1000"}'
# update_test_genesis '.app_state["staking"]["params"]["bond_denom"]="stake"'


# copy validator1 genesis file to validator2-3
cp $HOME/.gaiad/validator1/config/genesis.json $HOME/.gaiad/validator2/config/genesis.json
cp $HOME/.gaiad/validator1/config/genesis.json $HOME/.gaiad/validator3/config/genesis.json

# copy tendermint node id of validator1 to persistent peers of validator2-3
node1=$(gaiad tendermint show-node-id --home=$HOME/.gaiad/validator1)
node2=$(gaiad tendermint show-node-id --home=$HOME/.gaiad/validator2)
node3=$(gaiad tendermint show-node-id --home=$HOME/.gaiad/validator3)
sed -i -E "s|persistent_peers = \"\"|persistent_peers = \"$node1@localhost:26656,$node2@localhost:26653,$node3@localhost:26650\"|g" $HOME/.gaiad/validator1/config/config.toml
sed -i -E "s|persistent_peers = \"\"|persistent_peers = \"$node1@localhost:26656,$node2@localhost:26653,$node3@localhost:26650\"|g" $HOME/.gaiad/validator2/config/config.toml
sed -i -E "s|persistent_peers = \"\"|persistent_peers = \"$node1@localhost:26656,$node2@localhost:26653,$node3@localhost:26650\"|g" $HOME/.gaiad/validator3/config/config.toml


# # start all three validators/
# gaiad start --home=$HOME/.gaiad/validator1
screen -S gaia1 -t gaia1 -d -m gaiad start --home=$HOME/.gaiad/validator1
screen -S gaia2 -t gaia2 -d -m gaiad start --home=$HOME/.gaiad/validator2
screen -S gaia3 -t gaia3 -d -m gaiad start --home=$HOME/.gaiad/validator3
# gaiad start --home=$HOME/.gaiad/validator3

# screen -r gaia1

sleep 7

# gaiad tx bank send $(gaiad keys show validator1 -a --keyring-backend=test --home=$HOME/.gaiad/validator1) $(gaiad keys show validator2 -a --keyring-backend=test --home=$HOME/.gaiad/validator2) 100000stake --keyring-backend=test --chain-id=testing-1 -y --home=$HOME/.gaiad/validator1 --fees 10stake

# sleep 7
gaiad tx bank send cosmos1f7twgcq4ypzg7y24wuywy06xmdet8pc4473tnq cosmos1qvuhm5m644660nd8377d6l7yz9e9hhm9evmx3x 10000000000000000000000stake --keyring-backend=test --chain-id=testing-1 -y --home=$HOME/.gaiad/validator1 --fees 200000stake
# sleep 7
# gaiad tx bank send gaia1f7twgcq4ypzg7y24wuywy06xmdet8pc4hhtf9t gaia16gjg8p5fedy48wf403jwmz2cxlwqtkqlwe0lug 10000000000000000000000stake --keyring-backend=test --chain-id=testing-1 -y --home=$HOME/.gaiad/validator1 --fees 10stake

