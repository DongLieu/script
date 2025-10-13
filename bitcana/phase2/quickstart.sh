# ===================================================================================================|
# ==================================NEW BINARY=======================================================|
# ===================================================================================================|
HOME_MAINNET=$HOME/.bcnad/validator1
HOME_FORK=$HOME/.bcnad-tooling2
# start new binary
cd /Users/donglieu/1025/bitcanna/bcna/
go install ./...
cd /Users/donglieu/script/bitcana/phase2
## mkdir 
rm -rf $HOME_FORK
mkdir $HOME_FORK
# ...
bcnad init --chain-id=testing-1 validator1 --home=$HOME_FORK

# copy data
cp -r $HOME_MAINNET/data $HOME_FORK
bcnad export --home=$HOME_MAINNET > $HOME_FORK/config/genesis.json

# config
VALIDATORp2_APP_TOML=$HOME_FORK/config/app.toml
VALIDATORp2_CONFIG=$HOME_FORK/config/config.toml
sed -i -E 's|minimum-gas-prices = ""|minimum-gas-prices = "0.0001stake"|g' $VALIDATORp2_APP_TOML
sed -i -E 's|enable = false|enable = true|g' $VALIDATORp2_APP_TOML
# sed -i -E 's|skip_timeout_commit = false|skip_timeout_commit = true|g' $VALIDATORp2_CONFIG

bcnad start --home=$HOME_FORK --log_level debug