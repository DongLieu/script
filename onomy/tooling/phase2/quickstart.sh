# ===================================================================================================|
# ==================================NEW BINARY=======================================================|
# ===================================================================================================|
HOME_MAINNET=$HOME/.onomyd/validator1
HOME_FORK=$HOME/.onomyd-tooling2
# start new binary
cd /Users/donglieu/925/onomy/
go install ./...
cd /Users/donglieu/script/onomy/tooling/phase2
## mkdir 
rm -rf $HOME_FORK
mkdir $HOME_FORK
# ...
onomyd init --chain-id=testing-1 validator1 --home=$HOME_FORK

# copy data
cp -r $HOME_MAINNET/data $HOME_FORK
onomyd export --home=$HOME_MAINNET > $HOME_FORK/config/genesis.json

# config
VALIDATORp2_APP_TOML=$HOME_FORK/config/app.toml
VALIDATORp2_CONFIG=$HOME_FORK/config/config.toml
sed -i -E 's|minimum-gas-prices = ""|minimum-gas-prices = "0.0001stake"|g' $VALIDATORp2_APP_TOML
sed -i -E 's|skip_timeout_commit = false|skip_timeout_commit = true|g' $VALIDATORp2_CONFIG

onomyd start --home=$HOME_FORK --log_level debug