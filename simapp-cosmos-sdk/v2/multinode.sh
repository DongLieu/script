#!/bin/bash
# set -xeu

# # always returns true so set -e doesn't exit if it is not running.
killall simdv2 || true
rm -rf $HOME/.simdv2/

# make four sim directories
mkdir $HOME/.simdv2
mkdir $HOME/.simdv2/validator1
mkdir $HOME/.simdv2/validator2
mkdir $HOME/.simdv2/validator3

# init all three validators
simdv2 init --chain-id=testing-1 validator1 --home=$HOME/.simdv2/validator1
simdv2 init --chain-id=testing-1 validator2 --home=$HOME/.simdv2/validator2
simdv2 init --chain-id=testing-1 validator3 --home=$HOME/.simdv2/validator3

# create keys for all three validators
# sim1f7twgcq4ypzg7y24wuywy06xmdet8pc4hhtf9t
echo $(cat /Users/donglieu/script/keys/mnemonic1)| simdv2 keys add validator1 --recover --keyring-backend=test --home=$HOME/.simdv2/validator1
# sim1w7f3xx7e75p4l7qdym5msqem9rd4dyc4uasjhr
echo $(cat /Users/donglieu/script/keys/mnemonic2)| simdv2 keys add validator2 --recover --keyring-backend=test --home=$HOME/.simdv2/validator2
# sim1g9v3zjt6rfkwm4s8sw9wu4jgz9me8pn2uqa3jn
echo $(cat /Users/donglieu/script/keys/mnemonic3)| simdv2 keys add validator3 --recover --keyring-backend=test --home=$HOME/.simdv2/validator3

# create validator node with tokens to transfer to the three other nodes
simdv2 genesis add-genesis-account cosmos1wa3u4knw74r598quvzydvca42qsmk6jrzmgy07 10000000000000000000000000000000stake,10000000000000000000000000000000usim --home=$HOME/.simdv2/validator1 
simdv2 genesis add-genesis-account cosmos1w7f3xx7e75p4l7qdym5msqem9rd4dyc4752spg 10000000000000000000000000000000stake,10000000000000000000000000000000usim --home=$HOME/.simdv2/validator1 
simdv2 genesis add-genesis-account cosmos1g9v3zjt6rfkwm4s8sw9wu4jgz9me8pn27f8nyc 10000000000000000000000000000000stake,10000000000000000000000000000000usim --home=$HOME/.simdv2/validator1
simdv2 genesis add-genesis-account cosmos1wa3u4knw74r598quvzydvca42qsmk6jrzmgy07 10000000000000000000000000000000stake,10000000000000000000000000000000usim --home=$HOME/.simdv2/validator2
simdv2 genesis add-genesis-account cosmos1w7f3xx7e75p4l7qdym5msqem9rd4dyc4752spg 10000000000000000000000000000000stake,10000000000000000000000000000000usim --home=$HOME/.simdv2/validator2 
simdv2 genesis add-genesis-account cosmos1g9v3zjt6rfkwm4s8sw9wu4jgz9me8pn27f8nyc 10000000000000000000000000000000stake,10000000000000000000000000000000usim --home=$HOME/.simdv2/validator2 
simdv2 genesis add-genesis-account cosmos1wa3u4knw74r598quvzydvca42qsmk6jrzmgy07 10000000000000000000000000000000stake,10000000000000000000000000000000usim --home=$HOME/.simdv2/validator3 
simdv2 genesis add-genesis-account cosmos1w7f3xx7e75p4l7qdym5msqem9rd4dyc4752spg 10000000000000000000000000000000stake,10000000000000000000000000000000usim --home=$HOME/.simdv2/validator3 
simdv2 genesis add-genesis-account cosmos1g9v3zjt6rfkwm4s8sw9wu4jgz9me8pn27f8nyc 10000000000000000000000000000000stake,10000000000000000000000000000000usim --home=$HOME/.simdv2/validator3
simdv2 genesis gentx validator1 1000000000000000000000stake --keyring-backend=test --home=$HOME/.simdv2/validator1 --chain-id=testing-1
simdv2 genesis gentx validator2 1000000000000000000000stake --keyring-backend=test --home=$HOME/.simdv2/validator2 --chain-id=testing-1
simdv2 genesis gentx validator3 1000000000000000000000stake --keyring-backend=test --home=$HOME/.simdv2/validator3 --chain-id=testing-1

cp $HOME/.simdv2/validator2/config/gentx/*.json $HOME/.simdv2/validator1/config/gentx/
cp $HOME/.simdv2/validator3/config/gentx/*.json $HOME/.simdv2/validator1/config/gentx/
simdv2 genesis collect-gentxs --home=$HOME/.simdv2/validator1 
simdv2 genesis collect-gentxs --home=$HOME/.simdv2/validator2
simdv2 genesis collect-gentxs --home=$HOME/.simdv2/validator3 

cp $HOME/.simdv2/validator1/config/genesis.json $HOME/.simdv2/validator2/config/genesis.json
cp $HOME/.simdv2/validator1/config/genesis.json $HOME/.simdv2/validator3/config/genesis.json


# change app.toml values
VALIDATOR1_APP_TOML=$HOME/.simdv2/validator1/config/app.toml
VALIDATOR2_APP_TOML=$HOME/.simdv2/validator2/config/app.toml
VALIDATOR3_APP_TOML=$HOME/.simdv2/validator3/config/app.toml

# validator1
sed -i -E 's|localhost:9090|localhost:9050|g' $VALIDATOR1_APP_TOML
# validator2
sed -i -E 's|localhost:8090|localhost:8093|g' $VALIDATOR2_APP_TOML
sed -i -E 's|localhost:7180|localhost:7183|g' $VALIDATOR2_APP_TOML
sed -i -E 's|localhost:8080|localhost:8083|g' $VALIDATOR2_APP_TOML
sed -i -E 's|tcp://127.0.0.1:26658|tcp://127.0.0.1:26655|g' $VALIDATOR2_APP_TOML
sed -i -E 's|localhost:1317|localhost:1316|g' $VALIDATOR2_APP_TOML
sed -i -E 's|localhost:9090|localhost:9088|g' $VALIDATOR2_APP_TOML
sed -i -E 's|localhost:9091|localhost:9089|g' $VALIDATOR2_APP_TOML
sed -i -E 's|0.0.0.0:10337|0.0.0.0:10347|g' $VALIDATOR2_APP_TOML

# validator3
sed -i -E 's|localhost:8090|localhost:8096|g' $VALIDATOR3_APP_TOML
sed -i -E 's|localhost:7180|localhost:7186|g' $VALIDATOR3_APP_TOML
sed -i -E 's|localhost:8080|localhost:8086|g' $VALIDATOR3_APP_TOML
sed -i -E 's|tcp://127.0.0.1:26658|tcp://127.0.0.1:26652|g' $VALIDATOR3_APP_TOML
sed -i -E 's|localhost:1317|localhost:1315|g' $VALIDATOR3_APP_TOML
sed -i -E 's|localhost:9090|localhost:9086|g' $VALIDATOR3_APP_TOML
sed -i -E 's|localhost:9091|localhost:9087|g' $VALIDATOR3_APP_TOML
sed -i -E 's|0.0.0.0:10337|0.0.0.0:10357|g' $VALIDATOR3_APP_TOML

# change config.toml values
VALIDATOR1_CONFIG=$HOME/.simdv2/validator1/config/config.toml
VALIDATOR2_CONFIG=$HOME/.simdv2/validator2/config/config.toml
VALIDATOR3_CONFIG=$HOME/.simdv2/validator3/config/config.toml

# validator1
sed -i -E 's|allow_duplicate_ip = false|allow_duplicate_ip = true|g' $VALIDATOR1_CONFIG

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
cp $HOME/.simdv2/validator1/config/genesis.json $HOME/.simdv2/validator2/config/genesis.json
cp $HOME/.simdv2/validator1/config/genesis.json $HOME/.simdv2/validator3/config/genesis.json

# copy tendermint node id of validator1 to persistent peers of validator2-3
node1=$(simdv2 comet show-node-id --home=$HOME/.simdv2/validator1)
node2=$(simdv2 comet show-node-id --home=$HOME/.simdv2/validator2)
node3=$(simdv2 comet show-node-id --home=$HOME/.simdv2/validator3)
sed -i '' -E 's/(persistent_peers = ")([^"]*)(")/\1\2,'"${node1}@localhost:26658,${node2}@localhost:26653,${node3}@localhost:26650"'\3/' $HOME/.simdv2/validator1/config/config.toml
sed -i -E "s|persistent_peers = \"\"|persistent_peers = \"$node1@localhost:26658,$node2@localhost:26653,$node3@localhost:26650\"|g" $HOME/.simdv2/validator2/config/config.toml
sed -i -E "s|persistent_peers = \"\"|persistent_peers = \"$node1@localhost:26658,$node2@localhost:26653,$node3@localhost:26650\"|g" $HOME/.simdv2/validator3/config/config.toml


# # start all three validators/
screen -S sim1 -t sim1 -d -m simdv2 start --home=$HOME/.simdv2/validator1
screen -S sim2 -t sim2 -d -m simdv2 start --home=$HOME/.simdv2/validator2
screen -S sim3 -t sim3 -d -m simdv2 start --home=$HOME/.simdv2/validator3

# # screen -r sim1

# sleep 7

# simdv2 tx bank send cosmos1wa3u4knw74r598quvzydvca42qsmk6jrzmgy07 cosmos1w7f3xx7e75p4l7qdym5msqem9rd4dyc4752spg 1000000000000000000000stake --keyring-backend=test --chain-id=testing-1 -y --home=$HOME/.simdv2/validator1 --fees 10stake

# simdv2 q staking validators
# simdv2 keys list --keyring-backend=test --home=$HOME/.simdv2/validator1
# simdv2 keys list --keyring-backend=test --home=$HOME/.simdv2/validator2
# simdv2 keys list --keyring-backend=test --home=$HOME/.simdv2/validator3

