#!/bin/bash
set -xeu

# always returns true so set -e doesn't exit if it is not running.
killall bcnad || true
rm -rf $HOME/.bcnad/

mkdir $HOME/.bcnad
mkdir $HOME/.bcnad/validator1
mkdir $HOME/.bcnad/validator2
mkdir $HOME/.bcnad/validator3
mkdir $HOME/.bcnad/validator4

# init all three validators
bcnad init --chain-id=testing-1 validator1 --home=$HOME/.bcnad/validator1
bcnad init --chain-id=testing-1 validator2 --home=$HOME/.bcnad/validator2
bcnad init --chain-id=testing-1 validator3 --home=$HOME/.bcnad/validator3
bcnad init --chain-id=testing-1 validator4 --home=$HOME/.bcnad/validator4

# create keys for all three validators
mnemonic1="ozone unfold device pave lemon potato omit insect column wise cover hint narrow large provide kidney episode clay notable milk mention dizzy muffin crazy"
mnemonic2="soap step crash ceiling path virtual this armor accident pond share track spice woman vault discover share holiday inquiry oak shine scrub bulb arrive"
mnemonic3="travel jelly basic visa apart kidney piano lumber elevator fat unknown guard matter used high drastic umbrella humble crush stock banner enlist mule unique"
mnemonic4="improve fun aim fringe machine shed repair olympic copper buddy road used trial liquid energy diamond orange lock time exact away change icon spike"

echo $mnemonic1 | bcnad keys add validator1 --recover --keyring-backend=test --home=$HOME/.bcnad/validator1
# cosmos1w7f3xx7e75p4l7qdym5msqem9rd4dyc4752spg
echo $mnemonic2 | bcnad keys add validator2 --recover --keyring-backend=test --home=$HOME/.bcnad/validator2
# cosmos1g9v3zjt6rfkwm4s8sw9wu4jgz9me8pn27f8nyc
echo $mnemonic3| bcnad keys add validator3 --recover --keyring-backend=test --home=$HOME/.bcnad/validator3
echo $mnemonic4| bcnad keys add validator4 --recover --keyring-backend=test --home=$HOME/.bcnad/validator4

# create validator node with tokens to transfer to the three other nodes
bcnad genesis add-genesis-account $(bcnad keys show validator1 -a --keyring-backend=test --home=$HOME/.bcnad/validator1) 10000000000000000000000000000000stake,10000000000000000000000000000000usdt,1000000000000000000000ubcna --home=$HOME/.bcnad/validator1 
bcnad genesis add-genesis-account $(bcnad keys show validator2 -a --keyring-backend=test --home=$HOME/.bcnad/validator2) 10000000000000000000000000000000stake,10000000000000000000000000000000usdt,1000000000000000000000ubcna --home=$HOME/.bcnad/validator1 
bcnad genesis add-genesis-account $(bcnad keys show validator3 -a --keyring-backend=test --home=$HOME/.bcnad/validator3) 10000000000000000000000000000000stake,10000000000000000000000000000000usdt,1000000000000000000000ubcna --home=$HOME/.bcnad/validator1 
bcnad genesis add-genesis-account $(bcnad keys show validator4 -a --keyring-backend=test --home=$HOME/.bcnad/validator4) 10000000000000000000000000000000stake,10000000000000000000000000000000usdt,1000000000000000000000ubcna --home=$HOME/.bcnad/validator1 

bcnad genesis add-genesis-account $(bcnad keys show validator1 -a --keyring-backend=test --home=$HOME/.bcnad/validator1) 10000000000000000000000000000000stake,10000000000000000000000000000000usdt,1000000000000000000000ubcna --home=$HOME/.bcnad/validator2 
bcnad genesis add-genesis-account $(bcnad keys show validator2 -a --keyring-backend=test --home=$HOME/.bcnad/validator2) 10000000000000000000000000000000stake,10000000000000000000000000000000usdt,1000000000000000000000ubcna --home=$HOME/.bcnad/validator2 
bcnad genesis add-genesis-account $(bcnad keys show validator3 -a --keyring-backend=test --home=$HOME/.bcnad/validator3) 10000000000000000000000000000000stake,10000000000000000000000000000000usdt,1000000000000000000000ubcna --home=$HOME/.bcnad/validator2 
bcnad genesis add-genesis-account $(bcnad keys show validator4 -a --keyring-backend=test --home=$HOME/.bcnad/validator4) 10000000000000000000000000000000stake,10000000000000000000000000000000usdt,1000000000000000000000ubcna --home=$HOME/.bcnad/validator2 

bcnad genesis add-genesis-account $(bcnad keys show validator1 -a --keyring-backend=test --home=$HOME/.bcnad/validator1) 10000000000000000000000000000000stake,10000000000000000000000000000000usdt,1000000000000000000000ubcna --home=$HOME/.bcnad/validator3 
bcnad genesis add-genesis-account $(bcnad keys show validator2 -a --keyring-backend=test --home=$HOME/.bcnad/validator2) 10000000000000000000000000000000stake,10000000000000000000000000000000usdt,1000000000000000000000ubcna --home=$HOME/.bcnad/validator3 
bcnad genesis add-genesis-account $(bcnad keys show validator3 -a --keyring-backend=test --home=$HOME/.bcnad/validator3) 10000000000000000000000000000000stake,10000000000000000000000000000000usdt,1000000000000000000000ubcna --home=$HOME/.bcnad/validator3 
bcnad genesis add-genesis-account $(bcnad keys show validator4 -a --keyring-backend=test --home=$HOME/.bcnad/validator4) 10000000000000000000000000000000stake,10000000000000000000000000000000usdt,1000000000000000000000ubcna --home=$HOME/.bcnad/validator3

bcnad genesis add-genesis-account $(bcnad keys show validator1 -a --keyring-backend=test --home=$HOME/.bcnad/validator1) 10000000000000000000000000000000stake,10000000000000000000000000000000usdt,1000000000000000000000ubcna --home=$HOME/.bcnad/validator4 
bcnad genesis add-genesis-account $(bcnad keys show validator2 -a --keyring-backend=test --home=$HOME/.bcnad/validator2) 10000000000000000000000000000000stake,10000000000000000000000000000000usdt,1000000000000000000000ubcna --home=$HOME/.bcnad/validator4 
bcnad genesis add-genesis-account $(bcnad keys show validator3 -a --keyring-backend=test --home=$HOME/.bcnad/validator3) 10000000000000000000000000000000stake,10000000000000000000000000000000usdt,1000000000000000000000ubcna --home=$HOME/.bcnad/validator4 
bcnad genesis add-genesis-account $(bcnad keys show validator4 -a --keyring-backend=test --home=$HOME/.bcnad/validator4) 10000000000000000000000000000000stake,10000000000000000000000000000000usdt,1000000000000000000000ubcna --home=$HOME/.bcnad/validator4

bcnad genesis gentx validator1 1000000000000000000000stake --keyring-backend=test --home=$HOME/.bcnad/validator1 --chain-id=testing-1
bcnad genesis gentx validator2 1000000000000000000000stake --keyring-backend=test --home=$HOME/.bcnad/validator2 --chain-id=testing-1
bcnad genesis gentx validator3 1000000000000000000000stake --keyring-backend=test --home=$HOME/.bcnad/validator3 --chain-id=testing-1
bcnad genesis gentx validator4 1000000000000000000000stake --keyring-backend=test --home=$HOME/.bcnad/validator4 --chain-id=testing-1

cp $HOME/.bcnad/validator2/config/gentx/*.json $HOME/.bcnad/validator1/config/gentx/
cp $HOME/.bcnad/validator3/config/gentx/*.json $HOME/.bcnad/validator1/config/gentx/
cp $HOME/.bcnad/validator4/config/gentx/*.json $HOME/.bcnad/validator1/config/gentx/
bcnad genesis collect-gentxs --home=$HOME/.bcnad/validator1 

# change app.toml values
VALIDATOR1_APP_TOML=$HOME/.bcnad/validator1/config/app.toml
VALIDATOR2_APP_TOML=$HOME/.bcnad/validator2/config/app.toml
VALIDATOR3_APP_TOML=$HOME/.bcnad/validator3/config/app.toml
VALIDATOR4_APP_TOML=$HOME/.bcnad/validator4/config/app.toml

# validator1
# sed -i -E 's|localhost:9090|localhost:9050|g' $VALIDATOR1_APP_TOML
sed -i -E 's|localhost:9090|localhost:9050|g' $VALIDATOR1_APP_TOML
sed -i -E 's|minimum-gas-prices = ""|minimum-gas-prices = "0.0001stake"|g' $VALIDATOR1_APP_TOML
sed -i -E 's|enable = false|enable = true|g' $VALIDATOR1_APP_TOML

# validator2
sed -i -E 's|tcp://localhost:1317|tcp://0.0.0.0:1316|g' $VALIDATOR2_APP_TOML
sed -i -E 's|localhost:9090|localhost:9088|g' $VALIDATOR2_APP_TOML
sed -i -E 's|localhost:9091|localhost:9089|g' $VALIDATOR2_APP_TOML
sed -i -E 's|minimum-gas-prices = ""|minimum-gas-prices = "0.0001stake"|g' $VALIDATOR2_APP_TOML
sed -i -E 's|enable = false|enable = true|g' $VALIDATOR2_APP_TOML

# validator3
sed -i -E 's|tcp://localhost:1317|tcp://0.0.0.0:1315|g' $VALIDATOR3_APP_TOML
sed -i -E 's|localhost:9090|localhost:9086|g' $VALIDATOR3_APP_TOML
sed -i -E 's|localhost:9091|localhost:9087|g' $VALIDATOR3_APP_TOML
sed -i -E 's|minimum-gas-prices = ""|minimum-gas-prices = "0.0001stake"|g' $VALIDATOR3_APP_TOML
sed -i -E 's|enable = false|enable = true|g' $VALIDATOR3_APP_TOML

# validator4
sed -i -E 's|tcp://localhost:1317|tcp://0.0.0.0:1314|g' $VALIDATOR4_APP_TOML
sed -i -E 's|localhost:9090|localhost:9084|g' $VALIDATOR4_APP_TOML
sed -i -E 's|localhost:9091|localhost:9085|g' $VALIDATOR4_APP_TOML
sed -i -E 's|minimum-gas-prices = ""|minimum-gas-prices = "0.0001stake"|g' $VALIDATOR4_APP_TOML
sed -i -E 's|enable = false|enable = true|g' $VALIDATOR4_APP_TOML


# change config.toml values
VALIDATOR1_CONFIG=$HOME/.bcnad/validator1/config/config.toml
VALIDATOR2_CONFIG=$HOME/.bcnad/validator2/config/config.toml
VALIDATOR3_CONFIG=$HOME/.bcnad/validator3/config/config.toml
VALIDATOR4_CONFIG=$HOME/.bcnad/validator4/config/config.toml


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

# validator4
sed -i -E 's|tcp://127.0.0.1:26658|tcp://127.0.0.1:26649|g' $VALIDATOR4_CONFIG
sed -i -E 's|tcp://127.0.0.1:26657|tcp://127.0.0.1:26648|g' $VALIDATOR4_CONFIG
sed -i -E 's|tcp://0.0.0.0:26656|tcp://0.0.0.0:26647|g' $VALIDATOR4_CONFIG
sed -i -E 's|allow_duplicate_ip = false|allow_duplicate_ip = true|g' $VALIDATOR4_CONFIG
sed -i -E 's|prometheus = false|prometheus = true|g' $VALIDATOR4_CONFIG
sed -i -E 's|prometheus_listen_addr = ":26660"|prometheus_listen_addr = ":26610"|g' $VALIDATOR4_CONFIG


# copy validator1 genesis file to validator2-3
# update
update_test_genesis () {
    # EX: update_test_genesis '.consensus_params["block"]["max_gas"]="100000000"'
    cat $HOME/.bcnad/validator1/config/genesis.json | jq "$1" > tmp.json && mv tmp.json $HOME/.bcnad/validator1/config/genesis.json
}

update_test_genesis '.app_state["gov"]["voting_params"]["voting_period"] = "15s"'
update_test_genesis '.app_state["gov"]["params"]["voting_period"] = "15s"'
# update_test_genesis '.consensus["abci"]["vote_extensions_enable_height"] = "99999999999"'

cp $HOME/.bcnad/validator1/config/genesis.json $HOME/.bcnad/validator2/config/genesis.json
cp $HOME/.bcnad/validator1/config/genesis.json $HOME/.bcnad/validator3/config/genesis.json
cp $HOME/.bcnad/validator1/config/genesis.json $HOME/.bcnad/validator4/config/genesis.json

# copy tendermint node id of validator1 to persistent peers of validator2-3
node1=$(bcnad tendermint show-node-id --home=$HOME/.bcnad/validator1)
node2=$(bcnad tendermint show-node-id --home=$HOME/.bcnad/validator2)
node3=$(bcnad tendermint show-node-id --home=$HOME/.bcnad/validator3)
node4=$(bcnad tendermint show-node-id --home=$HOME/.bcnad/validator4)
peers="$node1@localhost:26656,$node2@localhost:26653,$node3@localhost:26650,$node4@localhost:26647"
# sed -i -E "s|persistent_peers = \"\"|persistent_peers = \"$node1@localhost:26656,$node2@localhost:26653,$node3@localhost:26650\"|g" $HOME/.bcnad/validator1/config/config.toml
sed -i.bak "s/^persistent_peers *=.*/persistent_peers = \"$peers\"/" "$VALIDATOR1_CONFIG"

# sed -i -E "s|persistent_peers = \"\"|persistent_peers = \"$node1@localhost:26656,$node2@localhost:26653,$node3@localhost:26650\"|g" $HOME/.bcnad/validator2/config/config.toml
sed -i.bak "s/^persistent_peers *=.*/persistent_peers = \"$peers\"/" "$VALIDATOR2_CONFIG"

# sed -i -E "s|persistent_peers = \"\"|persistent_peers = \"$node1@localhost:26656,$node2@localhost:26653,$node3@localhost:26650\"|g" $HOME/.bcnad/validator3/config/config.toml
sed -i.bak "s/^persistent_peers *=.*/persistent_peers = \"$peers\"/" "$VALIDATOR3_CONFIG"

sed -i.bak "s/^persistent_peers *=.*/persistent_peers = \"$peers\"/" "$VALIDATOR4_CONFIG"

# # start all three validators/
# bcnad start --home=$HOME/.bcnad/validator1
screen -S bcna1 -t bcna1 -d -m bcnad start --home=$HOME/.bcnad/validator1
screen -S bcna2 -t bcna2 -d -m bcnad start --home=$HOME/.bcnad/validator2
screen -S bcna3 -t bcna3 -d -m bcnad start --home=$HOME/.bcnad/validator3
screen -S bcna4 -t bcna4 -d -m bcnad start --home=$HOME/.bcnad/validator4
# bcnad start --home=$HOME/.bcnad/validator3

# sleep 7

# bcnad tx bank send bcna1wa3u4knw74r598quvzydvca42qsmk6jrctc98v bcna1w7f3xx7e75p4l7qdym5msqem9rd4dyc4yy63f6 9999999990000000000stake,100ubcna --keyring-backend=test --chain-id=testing-1 -y --home=$HOME/.bcnad/validator1 --fees 200ubcna --node tcp://localhost:26654
# sleep 7
# bcnad tx bank send bcna1wa3u4knw74r598quvzydvca42qsmk6jrc6uj7m bcna16gjg8p5fedy48wf403jwmz2cxlwqtkqlk3ptmx 999999999000000000000000000000stake,1000000000ubcna --keyring-backend=test --chain-id=testing-1 -y --home=$HOME/.bcnad/validator1 --fees 20stake
# sleep 7
# bcnad q staking validators
# bcnad keys list --keyring-backend=test --home=$HOME/.bcnad/validator1
# bcnad keys list --keyring-backend=test --home=$HOME/.bcnad/validator2
# bcnad keys list --keyring-backend=test --home=$HOME/.bcnad/validator3

# sleep 7
# killall bcnad || true
# bcnad in-place-testnet testing-1  bcnavaloper1wa3u4knw74r598quvzydvca42qsmk6jrya79zd --accounts-to-fund="bcna1wa3u4knw74r598quvzydvca42qsmk6jrc6uj7m,bcna1w7f3xx7e75p4l7qdym5msqem9rd4dyc4y47xsd,bcna1g9v3zjt6rfkwm4s8sw9wu4jgz9me8pn2ygn94a" --home=$HOME/.bcnad/validator1 --skip-confirmation

# bcnad tx gov submit-proposal  /Users/donglieu/script/bcna/du-upgarde.json --keyring-backend=test  --home=$HOME/.bcnad/validator1 --from bcna1wa3u4knw74r598quvzydvca42qsmk6jrc6uj7m -y --chain-id testing-1 --fees 20stake

# sleep 7
# bcnad tx gov vote 1 yes  --from validator1 --keyring-backend test --home ~/.bcnad/validator1 --chain-id testing-1 -y --fees 20stake
# bcnad tx gov vote 1 yes  --from validator2 --keyring-backend test --home ~/.bcnad/validator2 --chain-id testing-1 -y --fees 20stake
# bcnad tx gov vote 1 yes  --from validator3 --keyring-backend test --home ~/.bcnad/validator3 --chain-id testing-1 -y --fees 20stake

# sleep 15
# echo "==================="

# bcnad q bank balances bcna1wa3u4knw74r598quvzydvca42qsmk6jrc6uj7m
# echo "==================="
# bcnad tx psm swap-to-ist 100000000000000000000000000000usdt --from validator1 --keyring-backend test --home ~/.bcnad/validator1 --chain-id testing-1 -y

# sleep 7

# bcnad tx psm swap-to-stablecoin usdt 1000IST --from validator1 --keyring-backend test --home ~/.bcnad/validator1 --chain-id testing-1 -y

# modulenema: 3CF27F7408755A5E12B08812B22AD88CB17322B5
# bcna18ne87aqgw4d9uy4s3qfty2kc3jchxg44ec3vm5
# q tx 4FCCE5F1ECCBDEF75B153D0760D8114F0B6945E94CE18807135FE2C07DB65803
