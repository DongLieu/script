rm -rf $HOME/.injectived/

# init chain
injectived init test --chain-id testing-1

echo "ozone unfold device pave lemon potato omit insect column wise cover hint narrow large provide kidney episode clay notable milk mention dizzy muffin crazy"| injectived keys add val --keyring-backend test  --recover 

# injectived genesis add-genesis-account val 1000000000000stake --keyring-backend test
# injectived genesis add-genesis-account val2 1000000000000stake --keyring-backend test
injectived genesis add-genesis-account val 10000000000000000000000000000000stake --keyring-backend test  --chain-id testing-1
injectived genesis add-genesis-account val2 10000000000000000000000000000000stake --keyring-backend test  --chain-id testing-1


injectived genesis gentx val  1000000000000000000000000stake --keyring-backend test --chain-id testing-1
# # Collect genesis tx 
injectived genesis collect-gentxs
# # Run this to ensure everything worked and that the genesis file is setup correctly
# injectived validate
injectived genesis validate-genesis

sed -i -E 's|minimum-gas-prices = ""|minimum-gas-prices = "0.0001stake"|g' $HOME/.injectived/config/app.toml

VALIDATOR2_APP_TOML=$HOME/.injectived/config/app.toml
# validator2
sed -i -E 's|tcp://localhost:1317|tcp://localhost:1316|g' $VALIDATOR2_APP_TOML
sed -i -E 's|0.0.0.0:9900|0.0.0.0:9088|g' $VALIDATOR2_APP_TOML
sed -i -E 's|0.0.0.0:9091|0.0.0.0:9089|g' $VALIDATOR2_APP_TOML
sed -i -E 's|tcp://0.0.0.0:10337|tcp://0.0.0.0:10347|g' $VALIDATOR2_APP_TOML

VALIDATOR2_CONFIG=$HOME/.injectived/config/config.toml
# validator2
sed -i -E 's|tcp://127.0.0.1:26658|tcp://127.0.0.1:26655|g' $VALIDATOR2_CONFIG
sed -i -E 's|tcp://127.0.0.1:26657|tcp://127.0.0.1:26654|g' $VALIDATOR2_CONFIG
sed -i -E 's|tcp://0.0.0.0:26656|tcp://0.0.0.0:26653|g' $VALIDATOR2_CONFIG
sed -i -E 's|allow_duplicate_ip = false|allow_duplicate_ip = true|g' $VALIDATOR2_CONFIG
sed -i -E 's|prometheus = false|prometheus = true|g' $VALIDATOR2_CONFIG
sed -i -E 's|prometheus_listen_addr = ":26660"|prometheus_listen_addr = ":26630"|g' $VALIDATOR2_CONFIG

# screen -S xionx -t xionx -d -m
injectived start 