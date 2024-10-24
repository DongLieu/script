
# remove existing daemon
rm -rf ~/.gaia/

# if $KEY exists it should be deleted
mnm_val="soap step crash ceiling path virtual this armor accident pond share track spice woman vault discover share holiday inquiry oak shine scrub bulb arrive"


# Set moniker and chain-id for Evmos (Moniker can be anything, chain-id must be an integer)
gaiad init gaia-1 --chain-id testing-2 

echo "$mnm_val"| gaiad keys add val --recover --keyring-backend test 

# Allocate genesis accounts (cosmos formatted addresses)
gaiad genesis add-genesis-account val 100000000000000000000000000stake,1000000000000000000uatom --keyring-backend test

# Sign genesis transaction
gaiad genesis gentx val 1000000000000000000000stake --keyring-backend test --chain-id testing-2

# Collect genesis tx
gaiad genesis collect-gentxs

# Run this to ensure everything worked and that the genesis file is setup correctly
gaiad genesis validate-genesis

# validator2
VALIDATOR2_CONFIG=$HOME/.gaia/config/config.toml
sed -i -E 's|tcp://127.0.0.1:26658|tcp://127.0.0.1:26646|g' $VALIDATOR2_CONFIG
sed -i -E 's|tcp://127.0.0.1:26657|tcp://127.0.0.1:26645|g' $VALIDATOR2_CONFIG
sed -i -E 's|tcp://0.0.0.0:26656|tcp://0.0.0.0:26644|g' $VALIDATOR2_CONFIG
sed -i -E 's|allow_duplicate_ip = false|allow_duplicate_ip = true|g' $VALIDATOR2_CONFIG
sed -i -E 's|prometheus = false|prometheus = true|g' $VALIDATOR2_CONFIG
sed -i -E 's|prometheus_listen_addr = ":26660"|prometheus_listen_addr = ":26620"|g' $VALIDATOR2_CONFIG

VALIDATOR2_APP_TOML=$HOME/.gaia/config/app.toml
sed -i -E 's|tcp://localhost:1317|tcp://localhost:1313|g' $VALIDATOR2_APP_TOML
sed -i -E 's|localhost:9090|localhost:9082|g' $VALIDATOR2_APP_TOML
sed -i -E 's|localhost:9091|localhost:9081|g' $VALIDATOR2_APP_TOML
sed -i -E 's|tcp://0.0.0.0:10337|tcp://0.0.0.0:10377|g' $VALIDATOR2_APP_TOML

# Start the node (remove the --pruning=nothing flag if historical queries are not needed)
# gaiad start --pruning=nothing  --minimum-gas-prices=0.0001stake
