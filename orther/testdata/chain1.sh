KEY="mykey"
CHAINID="aura_6322-2"
MONIKER="localtestnet1"
KEYALGO="secp256k1"
KEYRING="test"
LOGLEVEL="info"

# remove existing daemon
rm -rf $HOME/.aura

aurad config keyring-backend $KEYRING
aurad config chain-id $CHAINID

# if $KEY exists it should be deleted
mnm_val=$(cat ./keys/mnemonic1)

echo "$mnm_val"| aurad keys add $KEY --recover --keyring-backend $KEYRING --algo $KEYALGO

# aurad keys add $KEY --keyring-backend $KEYRING --algo $KEYALGO

# Set moniker and chain-id for Evmos (Moniker can be anything, chain-id must be an integer)
aurad init $MONIKER --chain-id $CHAINID 

# Allocate genesis accounts (cosmos formatted addresses)
aurad add-genesis-account $KEY 100000000000000000000000000stake,1000000000000000000uaura --keyring-backend $KEYRING

# Sign genesis transaction
aurad gentx $KEY 1000000000000000000000stake --keyring-backend $KEYRING --chain-id $CHAINID

# Collect genesis tx
aurad collect-gentxs

# Run this to ensure everything worked and that the genesis file is setup correctly
aurad validate-genesis

# VALIDATOR2_APP_TOML=$HOME/.aura/config/app.toml
# sed -i -E 's|enable = false|enable = true|g' $VALIDATOR2_APP_TOML

# Start the node (remove the --pruning=nothing flag if historical queries are not needed)
aurad start --pruning=nothing  --minimum-gas-prices=0.0001stake


# enable = false