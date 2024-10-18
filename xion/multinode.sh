#!/bin/bash
set -xeu

# always returns true so set -e doesn't exit if it is not running.
killall xiond || true
rm -rf $HOME/.xiond/

# make four xion directories
mkdir $HOME/.xiond
cd $HOME/.xiond/
mkdir $HOME/.xiond/validator1
mkdir $HOME/.xiond/validator2
mkdir $HOME/.xiond/validator3

# init all three validators
xiond init --chain-id=testing-1 validator1 --home=$HOME/.xiond/validator1
xiond init --chain-id=testing-1 validator2 --home=$HOME/.xiond/validator2
xiond init --chain-id=testing-1 validator3 --home=$HOME/.xiond/validator3

# create keys for all three validators
# xion1f7twgcq4ypzg7y24wuywy06xmdet8pc4hhtf9t
echo $(cat /Users/donglieu/script/keys/mnemonic1)| xiond keys add validator1 --recover --keyring-backend=test --home=$HOME/.xiond/validator1
# xion1w7f3xx7e75p4l7qdym5msqem9rd4dyc4uasjhr
echo $(cat /Users/donglieu/script/keys/mnemonic2)| xiond keys add validator2 --recover --keyring-backend=test --home=$HOME/.xiond/validator2
# xion1g9v3zjt6rfkwm4s8sw9wu4jgz9me8pn2uqa3jn
echo $(cat /Users/donglieu/script/keys/mnemonic3)| xiond keys add validator3 --recover --keyring-backend=test --home=$HOME/.xiond/validator3

# create validator node with tokens to transfer to the three other nodes
xiond genesis add-genesis-account $(xiond keys show validator1 -a --keyring-backend=test --home=$HOME/.xiond/validator1) 10000000000000000000000000000000stake,10000000000000000000000000000000xion --home=$HOME/.xiond/validator1 
xiond genesis add-genesis-account $(xiond keys show validator2 -a --keyring-backend=test --home=$HOME/.xiond/validator2) 10000000000000000000000000000000stake,10000000000000000000000000000000xion --home=$HOME/.xiond/validator1 
xiond genesis add-genesis-account $(xiond keys show validator3 -a --keyring-backend=test --home=$HOME/.xiond/validator3) 10000000000000000000000000000000stake,10000000000000000000000000000000xion --home=$HOME/.xiond/validator1
xiond genesis add-genesis-account $(xiond keys show validator1 -a --keyring-backend=test --home=$HOME/.xiond/validator1) 10000000000000000000000000000000stake,10000000000000000000000000000000xion --home=$HOME/.xiond/validator2
xiond genesis add-genesis-account $(xiond keys show validator2 -a --keyring-backend=test --home=$HOME/.xiond/validator2) 10000000000000000000000000000000stake,10000000000000000000000000000000xion --home=$HOME/.xiond/validator2 
xiond genesis add-genesis-account $(xiond keys show validator3 -a --keyring-backend=test --home=$HOME/.xiond/validator3) 10000000000000000000000000000000stake,10000000000000000000000000000000xion --home=$HOME/.xiond/validator2 
xiond genesis add-genesis-account $(xiond keys show validator1 -a --keyring-backend=test --home=$HOME/.xiond/validator1) 10000000000000000000000000000000stake,10000000000000000000000000000000xion --home=$HOME/.xiond/validator3 
xiond genesis add-genesis-account $(xiond keys show validator2 -a --keyring-backend=test --home=$HOME/.xiond/validator2) 10000000000000000000000000000000stake,10000000000000000000000000000000xion --home=$HOME/.xiond/validator3 
xiond genesis add-genesis-account $(xiond keys show validator3 -a --keyring-backend=test --home=$HOME/.xiond/validator3) 10000000000000000000000000000000stake,10000000000000000000000000000000xion --home=$HOME/.xiond/validator3
xiond genesis gentx validator1 1000000000000000000000stake --keyring-backend=test --home=$HOME/.xiond/validator1 --chain-id=testing-1
xiond genesis gentx validator2 1000000000000000000000stake --keyring-backend=test --home=$HOME/.xiond/validator2 --chain-id=testing-1
xiond genesis gentx validator3 1000000000000000000000stake --keyring-backend=test --home=$HOME/.xiond/validator3 --chain-id=testing-1

cp validator2/config/gentx/*.json $HOME/.xiond/validator1/config/gentx/
cp validator3/config/gentx/*.json $HOME/.xiond/validator1/config/gentx/
xiond genesis collect-gentxs --home=$HOME/.xiond/validator1 
xiond genesis collect-gentxs --home=$HOME/.xiond/validator2
xiond genesis collect-gentxs --home=$HOME/.xiond/validator3 

cp validator1/config/genesis.json $HOME/.xiond/validator2/config/genesis.json
cp validator1/config/genesis.json $HOME/.xiond/validator3/config/genesis.json


# change app.toml values
VALIDATOR1_APP_TOML=$HOME/.xiond/validator1/config/app.toml
VALIDATOR2_APP_TOML=$HOME/.xiond/validator2/config/app.toml
VALIDATOR3_APP_TOML=$HOME/.xiond/validator3/config/app.toml

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
VALIDATOR1_CONFIG=$HOME/.xiond/validator1/config/config.toml
VALIDATOR2_CONFIG=$HOME/.xiond/validator2/config/config.toml
VALIDATOR3_CONFIG=$HOME/.xiond/validator3/config/config.toml


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
#     cat $HOME/.xiond/validator1/config/genesis.json | jq "$1" > tmp.json && mv tmp.json $HOME/.xiond/validator1/config/genesis.json
#     cat $HOME/.xiond/validator2/config/genesis.json | jq "$1" > tmp.json && mv tmp.json $HOME/.xiond/validator2/config/genesis.json
#     cat $HOME/.xiond/validator3/config/genesis.json | jq "$1" > tmp.json && mv tmp.json $HOME/.xiond/validator3/config/genesis.json
# }

# update_test_genesis '.app_state["gov"]["voting_params"]["voting_period"] = "30s"'
# update_test_genesis '.app_state["mint"]["params"]["mint_denom"]= "stake"'
# update_test_genesis '.app_state["gov"]["deposit_params"]["min_deposit"]=[{"denom": "stake","amount": "1000000"}]'
# update_test_genesis '.app_state["crisis"]["constant_fee"]={"denom": "stake","amount": "1000"}'
# update_test_genesis '.app_state["staking"]["params"]["bond_denom"]="stake"'


# copy validator1 genesis file to validator2-3
cp $HOME/.xiond/validator1/config/genesis.json $HOME/.xiond/validator2/config/genesis.json
cp $HOME/.xiond/validator1/config/genesis.json $HOME/.xiond/validator3/config/genesis.json

# copy tendermint node id of validator1 to persistent peers of validator2-3
node1=$(xiond tendermint show-node-id --home=$HOME/.xiond/validator1)
node2=$(xiond tendermint show-node-id --home=$HOME/.xiond/validator2)
node3=$(xiond tendermint show-node-id --home=$HOME/.xiond/validator3)
sed -i -E "s|persistent_peers = \"\"|persistent_peers = \"$node1@localhost:26656,$node2@localhost:26653,$node3@localhost:26650\"|g" $HOME/.xiond/validator1/config/config.toml
sed -i -E "s|persistent_peers = \"\"|persistent_peers = \"$node1@localhost:26656,$node2@localhost:26653,$node3@localhost:26650\"|g" $HOME/.xiond/validator2/config/config.toml
sed -i -E "s|persistent_peers = \"\"|persistent_peers = \"$node1@localhost:26656,$node2@localhost:26653,$node3@localhost:26650\"|g" $HOME/.xiond/validator3/config/config.toml


# # start all three validators/
# xiond start --home=$HOME/.xiond/validator1
screen -S xion1 -t xion1 -d -m xiond start --home=$HOME/.xiond/validator1
screen -S xion2 -t xion2 -d -m xiond start --home=$HOME/.xiond/validator2
screen -S xion3 -t xion3 -d -m xiond start --home=$HOME/.xiond/validator3
# xiond start --home=$HOME/.xiond/validator3

# screen -r xion1

sleep 7

xiond tx bank send $(xiond keys show validator1 -a --keyring-backend=test --home=$HOME/.xiond/validator1) xion1qvuhm5m644660nd8377d6l7yz9e9hhm9m9py8d 1000000000000000000000stake --keyring-backend=test --chain-id=testing-1 -y --home=$HOME/.xiond/validator1 --fees 10stake

xiond q staking validators
xiond keys list --keyring-backend=test --home=$HOME/.xiond/validator1
xiond keys list --keyring-backend=test --home=$HOME/.xiond/validator2
xiond keys list --keyring-backend=test --home=$HOME/.xiond/validator3

# xiond in-place-testnet testing-1 xionvaloper1qvuhm5m644660nd8377d6l7yz9e9hhm9sx2z07 --home $HOME/.xiond/validator4 --accounts-to-fund="xion1wa3u4knw74r598quvzydvca42qsmk6jrqjjxe4,xion1w7f3xx7e75p4l7qdym5msqem9rd4dyc4uasjhr,xion1g9v3zjt6rfkwm4s8sw9wu4jgz9me8pn2uqa3jn"