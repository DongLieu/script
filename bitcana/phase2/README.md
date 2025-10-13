

# Run mainnet simulation

start multinode by binary mainnet:
```
    git clone https://github.com/decentrio/bcna
    cd bcna
    git checkout v4.0.3
    go install ./...
```

```
    dir-path/multinode.sh
```

# Stop and config testnet(mainet fork)

`HOME_MAINNET` is home of node mainnet

`HOME_FORK` is home of node testnet(mainet fork)

- stop node:
```
killall bcnad || true
```

- build this new binary:
```
    git clone https://github.com/decentrio/bcna
    cd bcna
    git checkout v4.0.3
    git checkout dong/v4.0.3-tooling
    go install ./...
```

```
bcnad init --chain-id=testing-1 validator1 --home=$HOME_FORK

```

copy data and config:
```
    # copy data
    cp -r $HOME_MAINNET/data $HOME_FORK
    bcnad export --home=$HOME_MAINNET > $HOME_FORK/config/genesis.json

    # config
    VALIDATORp2_APP_TOML=$HOME_FORK/config/app.toml
    VALIDATORp2_CONFIG=$HOME_FORK/config/config.toml
    sed -i -E 's|minimum-gas-prices = ""|minimum-gas-prices = "0.0001stake"|g' $VALIDATORp2_APP_TOML
    sed -i -E 's|skip_timeout_commit = false|skip_timeout_commit = true|g' $VALIDATORp2_CONFIG
```

# Start

```
bcnad start --home=$HOME_FORK --log_level debug
```