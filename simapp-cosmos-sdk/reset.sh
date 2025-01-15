rm -rf node1
rm -rf node2
rm -rf node3

cp -r $HOME/.xiond/validator5/ node1
rm -rf node1/config/addrbook.json

cp -r node1 node2
cp -r node1 node3

rm node1/config/app.toml
rm node1/config/client.toml
rm node1/config/config.toml
rm node1/config/priv_validator_key.json
rm node1/config/node_key.json

rm node2/config/app.toml
rm node2/config/client.toml
rm node2/config/config.toml
rm node2/config/priv_validator_key.json
rm node2/config/node_key.json

rm node3/config/app.toml
rm node3/config/client.toml
rm node3/config/config.toml
rm node3/config/priv_validator_key.json
rm node3/config/node_key.json

cp config/config1/app.toml node1/config/app.toml
cp config/config1/client.toml node1/config/client.toml
cp config/config1/config.toml node1/config/config.toml
cp config/config1/priv_validator_key.json node1/config/priv_validator_key.json

cp config/config2/app.toml node2/config/app.toml
cp config/config2/client.toml node2/config/client.toml
cp config/config2/config.toml node2/config/config.toml
cp config/config2/priv_validator_key.json node2/config/priv_validator_key.json

cp config/config3/app.toml node3/config/app.toml
cp config/config3/client.toml node3/config/client.toml
cp config/config3/config.toml node3/config/config.toml
cp config/config3/priv_validator_key.json node3/config/priv_validator_key.json
