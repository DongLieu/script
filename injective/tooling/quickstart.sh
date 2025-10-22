# ===================================================================================================|
# ==================================NEW BINARY=======================================================|
# ===================================================================================================|
HOME_MAINNET=$HOME/.injectived
HOME_FORK=$HOME/.injective-tooling
# start new binary
cd /Users/donglieu/1125/inj/injective-core
go install ./...
cd /Users/donglieu/script/injective/tooling
## mkdir 
rm -rf $HOME_FORK
mkdir $HOME_FORK
# ...
# injectived init --chain-id=injective-1 validator1 --home=$HOME_FORK

# copy data
cp -r $HOME_MAINNET/ $HOME_FORK/
# cp $HOME_MAINNET/config/genesis.json  $HOME_FORK/config/genesis.json
# injectived export --home=$HOME_MAINNET > $HOME_FORK/config/genesis.json

# config
VALIDATORp2_APP_TOML=$HOME_FORK/config/app.toml
VALIDATORp2_CONFIG=$HOME_FORK/config/config.toml
sed -i -E 's|minimum-gas-prices = ""|minimum-gas-prices = "0.0001stake"|g' $VALIDATORp2_APP_TOML
sed -i -E 's|enable = false|enable = true|g' $VALIDATORp2_APP_TOML
# sed -i -E 's|skip_timeout_commit = false|skip_timeout_commit = true|g' $VALIDATORp2_CONFIG

injectived start --home=$HOME_FORK 