# start 3 node 
rm -rf $HOME/.onomyd/

mkdir $HOME/.onomyd
mkdir $HOME/.onomyd/validator1
mkdir $HOME/.onomyd/validator2
mkdir $HOME/.onomyd/validator3

onomyd init --chain-id onomy-mainnet-1 validator1 --home=$HOME/.onomyd/validator1
onomyd init --chain-id onomy-mainnet-1 validator2 --home=$HOME/.onomyd/validator2
onomyd init --chain-id onomy-mainnet-1 validator3 --home=$HOME/.onomyd/validator3

echo $(cat /Users/donglieu/script/keys/mnemonic6)| onomyd keys add validator1 --recover --keyring-backend=test --home=$HOME/.onomyd/validator1
echo $(cat /Users/donglieu/script/keys/mnemonic5)| onomyd keys add validator2 --recover --keyring-backend=test --home=$HOME/.onomyd/validator2
echo $(cat /Users/donglieu/script/keys/mnemonic4)| onomyd keys add validator3 --recover --keyring-backend=test --home=$HOME/.onomyd/validator3

cp $HOME/.onomy/config/genesis.json $HOME/.onomyd/validator1/config/genesis.json
cp $HOME/.onomy/config/genesis.json $HOME/.onomyd/validator2/config/genesis.json
cp $HOME/.onomy/config/genesis.json $HOME/.onomyd/validator3/config/genesis.json


rm -rf $HOME/.onomyd/validator1/data
cp -r $HOME/.onomy/data $HOME/.onomyd/validator1

rm -rf $HOME/.onomyd/validator2/data
cp -r $HOME/.onomy/data $HOME/.onomyd/validator2

rm -rf $HOME/.onomyd/validator3/data
cp -r $HOME/.onomy/data $HOME/.onomyd/validator3

# change app.toml values
VALIDATOR1_APP_TOML=$HOME/.onomyd/validator1/config/app.toml
VALIDATOR2_APP_TOML=$HOME/.onomyd/validator2/config/app.toml
VALIDATOR3_APP_TOML=$HOME/.onomyd/validator3/config/app.toml

# validator1
sed -i -E 's|tcp://0.0.0.0:1317|tcp://0.0.0.0:1313|g' $VALIDATOR1_APP_TOML
sed -i -E 's|0.0.0.0:9090|0.0.0.0:9082|g' $VALIDATOR1_APP_TOML
sed -i -E 's|0.0.0.0:9091|0.0.0.0:9083|g' $VALIDATOR1_APP_TOML
sed -i -E 's|tcp://0.0.0.0:10337|tcp://0.0.0.0:10377|g' $VALIDATOR1_APP_TOML

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
VALIDATOR1_CONFIG=$HOME/.onomyd/validator1/config/config.toml
VALIDATOR2_CONFIG=$HOME/.onomyd/validator2/config/config.toml
VALIDATOR3_CONFIG=$HOME/.onomyd/validator3/config/config.toml


# validator1
sed -i -E 's|tcp://127.0.0.1:26658|tcp://127.0.0.1:26639|g' $VALIDATOR1_CONFIG
sed -i -E 's|tcp://127.0.0.1:26657|tcp://127.0.0.1:26638|g' $VALIDATOR1_CONFIG
sed -i -E 's|tcp://0.0.0.0:26656|tcp://0.0.0.0:26644|g' $VALIDATOR1_CONFIG
sed -i -E 's|allow_duplicate_ip = false|allow_duplicate_ip = true|g' $VALIDATOR1_CONFIG
sed -i -E 's|prometheus = false|prometheus = true|g' $VALIDATOR1_CONFIG
sed -i -E 's|prometheus_listen_addr = ":26660"|prometheus_listen_addr = ":26690"|g' $VALIDATOR1_CONFIG


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


# copy tendermint node id of validator1 to persistent peers of validator2-3
node0=$(onomyd tendermint show-node-id --home=$HOME/.onomy)
node1=$(onomyd tendermint show-node-id --home=$HOME/.onomyd/validator1)
node2=$(onomyd tendermint show-node-id --home=$HOME/.onomyd/validator2)
node3=$(onomyd tendermint show-node-id --home=$HOME/.onomyd/validator3)

sed -i -E "s|persistent_peers = \"\"|persistent_peers = \"$node0@localhost:26656,$node2@localhost:26653,$node3@localhost:26650,$node1@localhost:26644\"|g" $HOME/.onomyd/validator1/config/config.toml
sed -i -E "s|persistent_peers = \"\"|persistent_peers = \"$node0@localhost:26656,$node2@localhost:26653,$node3@localhost:26650,$node1@localhost:26644\"|g" $HOME/.onomyd/validator2/config/config.toml
sed -i -E "s|persistent_peers = \"\"|persistent_peers = \"$node0@localhost:26656,$node2@localhost:26653,$node3@localhost:26650,$node1@localhost:26644\"|g" $HOME/.onomyd/validator3/config/config.toml

screen -S onomy1 -t onomy1 -d -m onomyd start --home=$HOME/.onomyd/validator1
screen -S onomy2 -t onomy2 -d -m onomyd start --home=$HOME/.onomyd/validator2
screen -S onomy3 -t onomy3 -d -m onomyd start --home=$HOME/.onomyd/validator3

