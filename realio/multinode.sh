#!/bin/bash
set -xeu

# always returns true so set -e doesn't exit if it is not running.
killall realio-networkd || true
rm -rf $HOME/.realio-network/

# make four mesh directories
mkdir $HOME/.realio-network
mkdir $HOME/.realio-network/validator1
mkdir $HOME/.realio-network/validator2
mkdir $HOME/.realio-network/validator3

# init all three validators
realio-networkd init  --chain-id realio_3-2 validator1 --home=$HOME/.realio-network/validator1
realio-networkd init  --chain-id realio_3-2 validator2 --home=$HOME/.realio-network/validator2
realio-networkd init  --chain-id realio_3-2 validator3 --home=$HOME/.realio-network/validator3

# create keys for all three validators
# realio-networkd keys add validator1 --keyring-backend=test --home=$HOME/.realio-network/validator1/Users/donglieu/script/keys/mnemonic1
m1="salmon fashion film curve cause palace ancient honey cactus donkey inhale awful resource run junior evil impact border off jacket behave rifle agree eagle"
m2="method kiss layer inherit grain define lecture document corn giraffe galaxy salute ensure mixture release punch duty ridge comfort road cross short review trend"
m3="original attract brass stumble poverty mobile route soup door blanket engage differ give arrest faint stadium impose outdoor shine wrist lion envelope regular pluck"

echo $m1| realio-networkd keys add validator1 --keyring-backend test --recover --home=$HOME/.realio-network/validator1
# realio-networkd keys add validator2 --keyring-backend=test --home=$HOME/.realio-network/validator2
echo $m2| realio-networkd keys add validator2 --keyring-backend test  --recover --home=$HOME/.realio-network/validator2
# realio-networkd keys add validator3 --keyring-backend=test --home=$HOME/.realio-network/validator3
echo $m3| realio-networkd keys add validator3 --keyring-backend test  --recover --home=$HOME/.realio-network/validator3

# create validator node with tokens to transfer to the three other nodes
realio-networkd add-genesis-account $(realio-networkd keys show validator1 -a --keyring-backend=test --home=$HOME/.realio-network/validator1) 10000000000000000000000000000000stake,10000000000000000000000000000000osmo --home=$HOME/.realio-network/validator1 
realio-networkd add-genesis-account $(realio-networkd keys show validator2 -a --keyring-backend=test --home=$HOME/.realio-network/validator2) 10000000000000000000000000000000stake,10000000000000000000000000000000osmo --home=$HOME/.realio-network/validator1 
realio-networkd add-genesis-account $(realio-networkd keys show validator3 -a --keyring-backend=test --home=$HOME/.realio-network/validator3) 10000000000000000000000000000000stake,10000000000000000000000000000000osmo --home=$HOME/.realio-network/validator1 
realio-networkd add-genesis-account $(realio-networkd keys show validator1 -a --keyring-backend=test --home=$HOME/.realio-network/validator1) 10000000000000000000000000000000stake,10000000000000000000000000000000osmo --home=$HOME/.realio-network/validator2 
realio-networkd add-genesis-account $(realio-networkd keys show validator2 -a --keyring-backend=test --home=$HOME/.realio-network/validator2) 10000000000000000000000000000000stake,10000000000000000000000000000000osmo --home=$HOME/.realio-network/validator2 
realio-networkd add-genesis-account $(realio-networkd keys show validator3 -a --keyring-backend=test --home=$HOME/.realio-network/validator3) 10000000000000000000000000000000stake,10000000000000000000000000000000osmo --home=$HOME/.realio-network/validator2 
realio-networkd add-genesis-account $(realio-networkd keys show validator1 -a --keyring-backend=test --home=$HOME/.realio-network/validator1) 10000000000000000000000000000000stake,10000000000000000000000000000000osmo --home=$HOME/.realio-network/validator3 
realio-networkd add-genesis-account $(realio-networkd keys show validator2 -a --keyring-backend=test --home=$HOME/.realio-network/validator2) 10000000000000000000000000000000stake,10000000000000000000000000000000osmo --home=$HOME/.realio-network/validator3 
realio-networkd add-genesis-account $(realio-networkd keys show validator3 -a --keyring-backend=test --home=$HOME/.realio-network/validator3) 10000000000000000000000000000000stake,10000000000000000000000000000000osmo --home=$HOME/.realio-network/validator3 
realio-networkd gentx validator1 1000000000000000000000stake --keyring-backend=test --home=$HOME/.realio-network/validator1  --chain-id realio_3-2
realio-networkd gentx validator2 1000000000000000000000stake --keyring-backend=test --home=$HOME/.realio-network/validator2  --chain-id realio_3-2
realio-networkd gentx validator3 1000000000000000000000stake --keyring-backend=test --home=$HOME/.realio-network/validator3  --chain-id realio_3-2

cp $HOME/.realio-network/validator2/config/gentx/*.json $HOME/.realio-network/validator1/config/gentx/
cp $HOME/.realio-network/validator3/config/gentx/*.json $HOME/.realio-network/validator1/config/gentx/
realio-networkd collect-gentxs --home=$HOME/.realio-network/validator1 

# cp validator1/config/genesis.json $HOME/.realio-network/validator2/config/genesis.json
# cp validator1/config/genesis.json $HOME/.realio-network/validator3/config/genesis.json


# change app.toml values
VALIDATOR1_APP_TOML=$HOME/.realio-network/validator1/config/app.toml
VALIDATOR2_APP_TOML=$HOME/.realio-network/validator2/config/app.toml
VALIDATOR3_APP_TOML=$HOME/.realio-network/validator3/config/app.toml

# validator1
sed -i -E 's|0.0.0.0:9090|0.0.0.0:9050|g' $VALIDATOR1_APP_TOML
# sed -i -E 's|127.0.0.1:9090|127.0.0.1:9050|g' $VALIDATOR1_APP_TOML

# validator2
sed -i -E 's|0.0.0.0:1317|0.0.0.0:1316|g' $VALIDATOR2_APP_TOML
sed -i -E 's|0.0.0.0:9090|0.0.0.0:9088|g' $VALIDATOR2_APP_TOML
# sed -i -E 's|localhost:9090|localhost:9088|g' $VALIDATOR2_APP_TOML
sed -i -E 's|0.0.0.0:9091|0.0.0.0:9089|g' $VALIDATOR2_APP_TOML
# sed -i -E 's|localhost:9091|localhost:9089|g' $VALIDATOR2_APP_TOML
sed -i -E 's|127.0.0.1:8545|127.0.0.1:8535|g' $VALIDATOR2_APP_TOML

# validator3
sed -i -E 's|0.0.0.0:1317|0.0.0.0:1315|g' $VALIDATOR3_APP_TOML
sed -i -E 's|0.0.0.0:9090|0.0.0.0:9086|g' $VALIDATOR3_APP_TOML
# sed -i -E 's|localhost:9090|localhost:9086|g' $VALIDATOR3_APP_TOML
sed -i -E 's|0.0.0.0:9091|0.0.0.0:9087|g' $VALIDATOR3_APP_TOML
# sed -i -E 's|localhost:9091|localhost:9087|g' $VALIDATOR3_APP_TOML
sed -i -E 's|127.0.0.1:8545|127.0.0.1:8525|g' $VALIDATOR3_APP_TOML

# change config.toml values
VALIDATOR1_CONFIG=$HOME/.realio-network/validator1/config/config.toml
VALIDATOR2_CONFIG=$HOME/.realio-network/validator2/config/config.toml
VALIDATOR3_CONFIG=$HOME/.realio-network/validator3/config/config.toml


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
cp $HOME/.realio-network/validator1/config/genesis.json $HOME/.realio-network/validator2/config/genesis.json
cp $HOME/.realio-network/validator1/config/genesis.json $HOME/.realio-network/validator3/config/genesis.json

node1=$(realio-networkd tendermint show-node-id --home=$HOME/.realio-network/validator1)
node2=$(realio-networkd tendermint show-node-id --home=$HOME/.realio-network/validator2)
node3=$(realio-networkd tendermint show-node-id --home=$HOME/.realio-network/validator3)
sed -i -E "s|persistent_peers = \"\"|persistent_peers = \"$node1@localhost:26656,$node2@localhost:26656,$node3@localhost:26656\"|g" $HOME/.realio-network/validator1/config/config.toml
sed -i -E "s|persistent_peers = \"\"|persistent_peers = \"$node1@localhost:26656,$node2@localhost:26656,$node3@localhost:26656\"|g" $HOME/.realio-network/validator2/config/config.toml
sed -i -E "s|persistent_peers = \"\"|persistent_peers = \"$node1@localhost:26656,$node2@localhost:26656,$node3@localhost:26656\"|g" $HOME/.realio-network/validator3/config/config.toml


# # start all three validators/
# realio-networkd start --home=$HOME/.realio-network/validator1
screen -S mesh1 -t mesh1 -d -m realio-networkd start --home=$HOME/.realio-network/validator1
screen -S mesh2 -t mesh2 -d -m realio-networkd start --home=$HOME/.realio-network/validator2
# screen -S mesh3 -t mesh3 -d -m 
realio-networkd start --home=$HOME/.realio-network/validator3
# realio-networkd start --home=$HOME/.realio-network/validator3

sleep 7

realio-networkd tx bank send $(realio-networkd keys show validator1 -a --keyring-backend=test --home=$HOME/.realio-network/validator1) $(realio-networkd keys show validator2 -a --keyring-backend=test --home=$HOME/.realio-network/validator2) 100000stake --keyring-backend=test  --chain-id realio_3-2 -y --home=$HOME/.realio-network/validator1 --fees 10stake

