#!/bin/bash
set -xeu

# always returns true so set -e doesn't exit if it is not running.
killall junctiond || true
rm -rf $HOME/.junctiond/

mkdir $HOME/.junctiond
mkdir $HOME/.junctiond/validator1
mkdir $HOME/.junctiond/validator2
mkdir $HOME/.junctiond/validator3

# init all three validators
junctiond init --chain-id=testing-1 validator1 --home=$HOME/.junctiond/validator1
junctiond init --chain-id=testing-1 validator2 --home=$HOME/.junctiond/validator2
junctiond init --chain-id=testing-1 validator3 --home=$HOME/.junctiond/validator3

# create keys for all three validators
mnemonic1="ozone unfold device pave lemon potato omit insect column wise cover hint narrow large provide kidney episode clay notable milk mention dizzy muffin crazy"
mnemonic2="soap step crash ceiling path virtual this armor accident pond share track spice woman vault discover share holiday inquiry oak shine scrub bulb arrive"
mnemonic3="travel jelly basic visa apart kidney piano lumber elevator fat unknown guard matter used high drastic umbrella humble crush stock banner enlist mule unique"

echo $mnemonic1 | junctiond keys add validator1 --recover --keyring-backend=test --home=$HOME/.junctiond/validator1
# cosmos1w7f3xx7e75p4l7qdym5msqem9rd4dyc4752spg
echo $mnemonic2 | junctiond keys add validator2 --recover --keyring-backend=test --home=$HOME/.junctiond/validator2
# cosmos1g9v3zjt6rfkwm4s8sw9wu4jgz9me8pn27f8nyc
echo $mnemonic3| junctiond keys add validator3 --recover --keyring-backend=test --home=$HOME/.junctiond/validator3

# create validator node with tokens to transfer to the three other nodes
junctiond genesis add-genesis-account $(junctiond keys show validator1 -a --keyring-backend=test --home=$HOME/.junctiond/validator1) 10000000000000000000000000000000stake,10000000000000000000000000000000usdt,10000000000anom --home=$HOME/.junctiond/validator1 
junctiond genesis add-genesis-account $(junctiond keys show validator2 -a --keyring-backend=test --home=$HOME/.junctiond/validator2) 10000000000000000000000000000000stake,10000000000000000000000000000000usdt,10000000000anom --home=$HOME/.junctiond/validator1 
junctiond genesis add-genesis-account $(junctiond keys show validator3 -a --keyring-backend=test --home=$HOME/.junctiond/validator3) 10000000000000000000000000000000stake,10000000000000000000000000000000usdt,10000000000anom --home=$HOME/.junctiond/validator1 
junctiond genesis add-genesis-account $(junctiond keys show validator1 -a --keyring-backend=test --home=$HOME/.junctiond/validator1) 10000000000000000000000000000000stake,10000000000000000000000000000000usdt,10000000000anom --home=$HOME/.junctiond/validator2 
junctiond genesis add-genesis-account $(junctiond keys show validator2 -a --keyring-backend=test --home=$HOME/.junctiond/validator2) 10000000000000000000000000000000stake,10000000000000000000000000000000usdt,10000000000anom --home=$HOME/.junctiond/validator2 
junctiond genesis add-genesis-account $(junctiond keys show validator3 -a --keyring-backend=test --home=$HOME/.junctiond/validator3) 10000000000000000000000000000000stake,10000000000000000000000000000000usdt,10000000000anom --home=$HOME/.junctiond/validator2 
junctiond genesis add-genesis-account $(junctiond keys show validator1 -a --keyring-backend=test --home=$HOME/.junctiond/validator1) 10000000000000000000000000000000stake,10000000000000000000000000000000usdt,10000000000anom --home=$HOME/.junctiond/validator3 
junctiond genesis add-genesis-account $(junctiond keys show validator2 -a --keyring-backend=test --home=$HOME/.junctiond/validator2) 10000000000000000000000000000000stake,10000000000000000000000000000000usdt,10000000000anom --home=$HOME/.junctiond/validator3 
junctiond genesis add-genesis-account $(junctiond keys show validator3 -a --keyring-backend=test --home=$HOME/.junctiond/validator3) 10000000000000000000000000000000stake,10000000000000000000000000000000usdt,10000000000anom --home=$HOME/.junctiond/validator3 
junctiond genesis gentx validator1 1000000000000000000000stake --keyring-backend=test --home=$HOME/.junctiond/validator1 --chain-id=testing-1
junctiond genesis gentx validator2 1000000000000000000000stake --keyring-backend=test --home=$HOME/.junctiond/validator2 --chain-id=testing-1
junctiond genesis gentx validator3 1000000000000000000000stake --keyring-backend=test --home=$HOME/.junctiond/validator3 --chain-id=testing-1

cp $HOME/.junctiond/validator2/config/gentx/*.json $HOME/.junctiond/validator1/config/gentx/
cp $HOME/.junctiond/validator3/config/gentx/*.json $HOME/.junctiond/validator1/config/gentx/
junctiond genesis collect-gentxs --home=$HOME/.junctiond/validator1 

# change app.toml values
VALIDATOR1_APP_TOML=$HOME/.junctiond/validator1/config/app.toml
VALIDATOR2_APP_TOML=$HOME/.junctiond/validator2/config/app.toml
VALIDATOR3_APP_TOML=$HOME/.junctiond/validator3/config/app.toml

# validator1
sed -i -E 's|0.0.0.0:9090|0.0.0.0:9050|g' $VALIDATOR1_APP_TOML
sed -i -E 's|127.0.0.1:9090|127.0.0.1:9050|g' $VALIDATOR1_APP_TOML
sed -i -E 's|minimum-gas-prices = ""|minimum-gas-prices = "0.0001stake"|g' $VALIDATOR1_APP_TOML

# validator2
sed -i -E 's|tcp://0.0.0.0:1317|tcp://0.0.0.0:1316|g' $VALIDATOR2_APP_TOML
sed -i -E 's|0.0.0.0:9090|0.0.0.0:9088|g' $VALIDATOR2_APP_TOML
sed -i -E 's|0.0.0.0:9091|0.0.0.0:9089|g' $VALIDATOR2_APP_TOML
sed -i -E 's|minimum-gas-prices = ""|minimum-gas-prices = "0.0001stake"|g' $VALIDATOR2_APP_TOML

# validator3
sed -i -E 's|tcp://0.0.0.0:1317|tcp://0.0.0.0:1315|g' $VALIDATOR3_APP_TOML
sed -i -E 's|0.0.0.0:9090|0.0.0.0:9086|g' $VALIDATOR3_APP_TOML
sed -i -E 's|0.0.0.0:9091|0.0.0.0:9087|g' $VALIDATOR3_APP_TOML
sed -i -E 's|minimum-gas-prices = ""|minimum-gas-prices = "0.0001stake"|g' $VALIDATOR3_APP_TOML

# change config.toml values
VALIDATOR1_CONFIG=$HOME/.junctiond/validator1/config/config.toml
VALIDATOR2_CONFIG=$HOME/.junctiond/validator2/config/config.toml
VALIDATOR3_CONFIG=$HOME/.junctiond/validator3/config/config.toml


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

# copy validator1 genesis file to validator2-3
# update
update_test_genesis () {
    # EX: update_test_genesis '.consensus_params["block"]["max_gas"]="100000000"'
    cat $HOME/.junctiond/validator1/config/genesis.json | jq "$1" > tmp.json && mv tmp.json $HOME/.junctiond/validator1/config/genesis.json
}

update_test_genesis '.app_state["gov"]["voting_params"]["voting_period"] = "15s"'
update_test_genesis '.app_state["gov"]["params"]["voting_period"] = "15s"'

cp $HOME/.junctiond/validator1/config/genesis.json $HOME/.junctiond/validator2/config/genesis.json
cp $HOME/.junctiond/validator1/config/genesis.json $HOME/.junctiond/validator3/config/genesis.json

# copy tendermint node id of validator1 to persistent peers of validator2-3
node1=$(junctiond tendermint show-node-id --home=$HOME/.junctiond/validator1)
node2=$(junctiond tendermint show-node-id --home=$HOME/.junctiond/validator2)
node3=$(junctiond tendermint show-node-id --home=$HOME/.junctiond/validator3)
sed -i -E "s|persistent_peers = \"\"|persistent_peers = \"$node1@localhost:26656,$node2@localhost:26656,$node3@localhost:26656\"|g" $HOME/.junctiond/validator1/config/config.toml
sed -i -E "s|persistent_peers = \"\"|persistent_peers = \"$node1@localhost:26656,$node2@localhost:26656,$node3@localhost:26656\"|g" $HOME/.junctiond/validator2/config/config.toml
sed -i -E "s|persistent_peers = \"\"|persistent_peers = \"$node1@localhost:26656,$node2@localhost:26656,$node3@localhost:26656\"|g" $HOME/.junctiond/validator3/config/config.toml


# # start all three validators/
# junctiond start --home=$HOME/.junctiond/validator1
screen -S junction1 -t junction1 -d -m junctiond start --home=$HOME/.junctiond/validator1
screen -S junction2 -t junction2 -d -m junctiond start --home=$HOME/.junctiond/validator2
screen -S junction3 -t junction3 -d -m junctiond start --home=$HOME/.junctiond/validator3
# junctiond start --home=$HOME/.junctiond/validator3
