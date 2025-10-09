

# Run mainnet simulation

start multinode by binary mainnet:
```
    git clone https://github.com/decentrio/onomy
    cd onomy
    git checkout cd6317f1b408cf50af8b661cdaa08febd9fe6c28
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
killall onomyd || true
```

- build this new binary:
```
    git clone https://github.com/decentrio/onomy
    cd onomy
    git checkout a5d0f01d4c58845e9d2134d5a52f783d76217ff6
    go install ./...
```

```
onomyd init --chain-id=testing-1 validator1 --home=$HOME_FORK

```

copy data and config:
```
    # copy data
    cp -r $HOME_MAINNET/data $HOME_FORK
    onomyd export --home=$HOME_MAINNET > $HOME_FORK/config/genesis.json

    # config
    VALIDATORp2_APP_TOML=$HOME_FORK/config/app.toml
    VALIDATORp2_CONFIG=$HOME_FORK/config/config.toml
    sed -i -E 's|minimum-gas-prices = ""|minimum-gas-prices = "0.0001stake"|g' $VALIDATORp2_APP_TOML
    sed -i -E 's|skip_timeout_commit = false|skip_timeout_commit = true|g' $VALIDATORp2_CONFIG
```

# Start

```
onomyd start --home=$HOME_FORK --log_level debug
```