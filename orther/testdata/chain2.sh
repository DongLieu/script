KEY="mykey"
CHAINID="cosmoshub-4"
MONIKER="localtestnet2"
KEYALGO="secp256k1"
KEYRING="test"
LOGLEVEL="info"

# remove existing daemon
rm -rf ~/.gaia*

gaiad config keyring-backend $KEYRING
gaiad config chain-id $CHAINID

# if $KEY exists it should be deleted
mnm_val=$(cat ./keys/mnemonic2)

echo "$mnm_val"| gaiad keys add $KEY --recover --keyring-backend $KEYRING --algo $KEYALGO


# Set moniker and chain-id for Evmos (Moniker can be anything, chain-id must be an integer)
gaiad init $MONIKER --chain-id $CHAINID 

# Allocate genesis accounts (cosmos formatted addresses)
gaiad genesis add-genesis-account $KEY 100000000000000000000000000stake,1000000000000000000uatom --keyring-backend $KEYRING

# Sign genesis transaction
gaiad genesis gentx $KEY 1000000000000000000000stake --keyring-backend $KEYRING --chain-id $CHAINID

# Collect genesis tx
gaiad genesis collect-gentxs

# Run this to ensure everything worked and that the genesis file is setup correctly
gaiad genesis validate-genesis

# validator2
VALIDATOR2_CONFIG=$HOME/.gaia/config/config.toml
sed -i -E 's|tcp://127.0.0.1:26658|tcp://127.0.0.1:26655|g' $VALIDATOR2_CONFIG
sed -i -E 's|tcp://127.0.0.1:26657|tcp://127.0.0.1:26654|g' $VALIDATOR2_CONFIG
sed -i -E 's|tcp://0.0.0.0:26656|tcp://0.0.0.0:26653|g' $VALIDATOR2_CONFIG
sed -i -E 's|allow_duplicate_ip = false|allow_duplicate_ip = true|g' $VALIDATOR2_CONFIG
sed -i -E 's|prometheus = false|prometheus = true|g' $VALIDATOR2_CONFIG
sed -i -E 's|prometheus_listen_addr = ":26660"|prometheus_listen_addr = ":26630"|g' $VALIDATOR2_CONFIG

VALIDATOR2_APP_TOML=$HOME/.gaia/config/app.toml
sed -i -E 's|tcp://localhost:1317|tcp://localhost:1316|g' $VALIDATOR2_APP_TOML
sed -i -E 's|localhost:9090|localhost:9088|g' $VALIDATOR2_APP_TOML
sed -i -E 's|localhost:9091|localhost:9089|g' $VALIDATOR2_APP_TOML
sed -i -E 's|tcp://0.0.0.0:10337|tcp://0.0.0.0:10347|g' $VALIDATOR2_APP_TOML

# Start the node (remove the --pruning=nothing flag if historical queries are not needed)
gaiad start --pruning=nothing  --minimum-gas-prices=0.0001stake
