#!/bin/bash
set -xeu

# always returns true so set -e doesn't exit if it is not running.
killall simd || true
rm -rf $HOME/.simd/

# make four sim directories
mkdir $HOME/.simd
cd $HOME/.simd/
mkdir $HOME/.simd/validator1
mkdir $HOME/.simd/validator2
mkdir $HOME/.simd/validator3

# init all three validators
simd init --chain-id=testing-1 validator1 --home=$HOME/.simd/validator1
simd init --chain-id=testing-1 validator2 --home=$HOME/.simd/validator2
simd init --chain-id=testing-1 validator3 --home=$HOME/.simd/validator3

# create keys for all three validators
# sim1f7twgcq4ypzg7y24wuywy06xmdet8pc4hhtf9t
echo $(cat /Users/donglieu/script/keys/mnemonic1)| simd keys add validator1 --recover --keyring-backend=test --home=$HOME/.simd/validator1
# sim1w7f3xx7e75p4l7qdym5msqem9rd4dyc4uasjhr
echo $(cat /Users/donglieu/script/keys/mnemonic2)| simd keys add validator2 --recover --keyring-backend=test --home=$HOME/.simd/validator2
# sim1g9v3zjt6rfkwm4s8sw9wu4jgz9me8pn2uqa3jn
echo $(cat /Users/donglieu/script/keys/mnemonic3)| simd keys add validator3 --recover --keyring-backend=test --home=$HOME/.simd/validator3

# create validator node with tokens to transfer to the three other nodes
simd genesis add-genesis-account $(simd keys show validator1 -a --keyring-backend=test --home=$HOME/.simd/validator1) 10000000000000000000000000000000stake,10000000000000000000000000000000usim --home=$HOME/.simd/validator1 
simd genesis add-genesis-account $(simd keys show validator2 -a --keyring-backend=test --home=$HOME/.simd/validator2) 10000000000000000000000000000000stake,10000000000000000000000000000000usim --home=$HOME/.simd/validator1 
simd genesis add-genesis-account $(simd keys show validator3 -a --keyring-backend=test --home=$HOME/.simd/validator3) 10000000000000000000000000000000stake,10000000000000000000000000000000usim --home=$HOME/.simd/validator1
simd genesis add-genesis-account $(simd keys show validator1 -a --keyring-backend=test --home=$HOME/.simd/validator1) 10000000000000000000000000000000stake,10000000000000000000000000000000usim --home=$HOME/.simd/validator2
simd genesis add-genesis-account $(simd keys show validator2 -a --keyring-backend=test --home=$HOME/.simd/validator2) 10000000000000000000000000000000stake,10000000000000000000000000000000usim --home=$HOME/.simd/validator2 
simd genesis add-genesis-account $(simd keys show validator3 -a --keyring-backend=test --home=$HOME/.simd/validator3) 10000000000000000000000000000000stake,10000000000000000000000000000000usim --home=$HOME/.simd/validator2 
simd genesis add-genesis-account $(simd keys show validator1 -a --keyring-backend=test --home=$HOME/.simd/validator1) 10000000000000000000000000000000stake,10000000000000000000000000000000usim --home=$HOME/.simd/validator3 
simd genesis add-genesis-account $(simd keys show validator2 -a --keyring-backend=test --home=$HOME/.simd/validator2) 10000000000000000000000000000000stake,10000000000000000000000000000000usim --home=$HOME/.simd/validator3 
simd genesis add-genesis-account $(simd keys show validator3 -a --keyring-backend=test --home=$HOME/.simd/validator3) 10000000000000000000000000000000stake,10000000000000000000000000000000usim --home=$HOME/.simd/validator3
simd genesis gentx validator1 1000000000000000000000stake --keyring-backend=test --home=$HOME/.simd/validator1 --chain-id=testing-1
simd genesis gentx validator2 1000000000000000000000stake --keyring-backend=test --home=$HOME/.simd/validator2 --chain-id=testing-1
simd genesis gentx validator3 1000000000000000000000stake --keyring-backend=test --home=$HOME/.simd/validator3 --chain-id=testing-1

cp validator2/config/gentx/*.json $HOME/.simd/validator1/config/gentx/
cp validator3/config/gentx/*.json $HOME/.simd/validator1/config/gentx/
simd genesis collect-gentxs --home=$HOME/.simd/validator1 
simd genesis collect-gentxs --home=$HOME/.simd/validator2
simd genesis collect-gentxs --home=$HOME/.simd/validator3 

cp validator1/config/genesis.json $HOME/.simd/validator2/config/genesis.json
cp validator1/config/genesis.json $HOME/.simd/validator3/config/genesis.json


# change app.toml values
VALIDATOR1_APP_TOML=$HOME/.simd/validator1/config/app.toml
VALIDATOR2_APP_TOML=$HOME/.simd/validator2/config/app.toml
VALIDATOR3_APP_TOML=$HOME/.simd/validator3/config/app.toml

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
VALIDATOR1_CONFIG=$HOME/.simd/validator1/config/config.toml
VALIDATOR2_CONFIG=$HOME/.simd/validator2/config/config.toml
VALIDATOR3_CONFIG=$HOME/.simd/validator3/config/config.toml


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

# update
update_test_genesis () {
    # EX: update_test_genesis '.consensus_params["block"]["max_gas"]="100000000"'
    cat $HOME/.simd/validator1/config/genesis.json | jq "$1" > tmp.json && mv tmp.json $HOME/.simd/validator1/config/genesis.json
    cat $HOME/.simd/validator2/config/genesis.json | jq "$1" > tmp.json && mv tmp.json $HOME/.simd/validator2/config/genesis.json
    cat $HOME/.simd/validator3/config/genesis.json | jq "$1" > tmp.json && mv tmp.json $HOME/.simd/validator3/config/genesis.json
}

update_test_genesis '.app_state["gov"]["params"]["expedited_voting_period"] = "300s"'
# update_test_genesis '.app_state["mint"]["params"]["mint_denom"]= "stake"'
# update_test_genesis '.app_state["gov"]["deposit_params"]["min_deposit"]=[{"denom": "stake","amount": "1000000"}]'
# update_test_genesis '.app_state["crisis"]["constant_fee"]={"denom": "stake","amount": "1000"}'
# update_test_genesis '.app_state["staking"]["params"]["bond_denom"]="stake"'


# copy validator1 genesis file to validator2-3
cp $HOME/.simd/validator1/config/genesis.json $HOME/.simd/validator2/config/genesis.json
cp $HOME/.simd/validator1/config/genesis.json $HOME/.simd/validator3/config/genesis.json

# copy tendermint node id of validator1 to persistent peers of validator2-3
node1=$(simd tendermint show-node-id --home=$HOME/.simd/validator1)
node2=$(simd tendermint show-node-id --home=$HOME/.simd/validator2)
node3=$(simd tendermint show-node-id --home=$HOME/.simd/validator3)
sed -i -E "s|persistent_peers = \"\"|persistent_peers = \"$node1@localhost:26656,$node2@localhost:26653,$node3@localhost:26650\"|g" $HOME/.simd/validator1/config/config.toml
sed -i -E "s|persistent_peers = \"\"|persistent_peers = \"$node1@localhost:26656,$node2@localhost:26653,$node3@localhost:26650\"|g" $HOME/.simd/validator2/config/config.toml
sed -i -E "s|persistent_peers = \"\"|persistent_peers = \"$node1@localhost:26656,$node2@localhost:26653,$node3@localhost:26650\"|g" $HOME/.simd/validator3/config/config.toml


# start all three validators/
# simd start --home=$HOME/.simd/validator1
screen -S sim1 -t sim1 -d -m simd start --home=$HOME/.simd/validator1
screen -S sim2 -t sim2 -d -m simd start --home=$HOME/.simd/validator2
screen -S sim3 -t sim3 -d -m simd start --home=$HOME/.simd/validator3
# simd start --home=$HOME/.simd/validator3

# screen -r sim1

sleep 7

simd tx bank send $(simd keys show validator1 -a --keyring-backend=test --home=$HOME/.simd/validator1) $(simd keys show validator2 -a --keyring-backend=test --home=$HOME/.simd/validator2) 1000000000000000000000stake --keyring-backend=test --chain-id=testing-1 -y --home=$HOME/.simd/validator1 --fees 10stake

sleep 7

simd tx bank send $(simd keys show validator1 -a --keyring-backend=test --home=$HOME/.simd/validator1) $(simd keys show validator3 -a --keyring-backend=test --home=$HOME/.simd/validator3) 1000000000000000000000stake --keyring-backend=test --chain-id=testing-1 -y --home=$HOME/.simd/validator1 --fees 10stake

sleep 7

simd tx gov submit-proposal /Users/donglieu/script/simapp-cosmos-sdk/gov-test.json --keyring-backend=test --chain-id=testing-1 -y --home=$HOME/.simd/validator1 --fees 10stake --from $(simd keys show validator1 -a --keyring-backend=test --home=$HOME/.simd/validator1)

sleep 7
simd tx gov deposit 1 1000000000000stake --keyring-backend=test --chain-id=testing-1 -y --home=$HOME/.simd/validator1 --fees 10stake --from $(simd keys show validator1 -a --keyring-backend=test --home=$HOME/.simd/validator1)

sleep 7

simd tx gov vote 1 yes --keyring-backend=test --chain-id=testing-1 -y --home=$HOME/.simd/validator1 --fees 10stake --from $(simd keys show validator1 -a --keyring-backend=test --home=$HOME/.simd/validator1)
sleep 7
simd tx gov vote 1 yes --keyring-backend=test --chain-id=testing-1 -y --home=$HOME/.simd/validator2 --fees 10stake --from $(simd keys show validator2 -a --keyring-backend=test --home=$HOME/.simd/validator2)
sleep 7
simd tx gov vote 1 yes --keyring-backend=test --chain-id=testing-1 -y --home=$HOME/.simd/validator3 --fees 10stake --from $(simd keys show validator3 -a --keyring-backend=test --home=$HOME/.simd/validator3)
# simd q staking validators

# simd keys list --keyring-backend=test --home=$HOME/.simd/validator1
# simd keys list --keyring-backend=test --home=$HOME/.simd/validator2
# simd keys list --keyring-backend=test --home=$HOME/.simd/validator3

# sleep 7
# killall simd || true

# simd in-place-testnet testing-1 simvaloper1wa3u4knw74r598quvzydvca42qsmk6jrt3eq3x --home $HOME/.simd/validator1 --accounts-to-fund="sim1wa3u4knw74r598quvzydvca42qsmk6jrqjjxe4,sim1w7f3xx7e75p4l7qdym5msqem9rd4dyc4uasjhr,sim1g9v3zjt6rfkwm4s8sw9wu4jgz9me8pn2uqa3jn"