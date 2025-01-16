onomyd tx vaults create-vault 125000000000000000000anom 50000000fxJPY --from val --home=$HOME/.onomy --keyring-backend test --chain-id onomy-mainnet-1 --fees 30stake --gas 300000 -y

onomyd tx vaults create-vault 125000000000000000000anom 50000000fxJPY --from val --home=$HOME/.onomy --keyring-backend test --chain-id onomy-mainnet-1 --fees 30stake --gas 300000 -y



onomyd tx bank send onomy1wa3u4knw74r598quvzydvca42qsmk6jrc6uj7m onomy1w7f3xx7e75p4l7qdym5msqem9rd4dyc4y47xsd  1000000000000000000000stake,99998875000000000000000000anom,1000000000000000000000ibc/40FA0DE5E13EAE0A1BE5AD395BB59DED023F4412F45550DD9944E1A62983D0BF,1000000000000000000000ibc/91B26889D009D6C4F7D3C62244521B67C27D42D60E0517681FA6C39D4078DA28,1000000000000000000000ibc/C4CFF46FD6DE35CA4CF4CE031E643C8FDC9BA4B99AE598E9B0ED98FE3A2319F9,1000000000000000000000ibc/F14D29B8CF730AEE5D65141F1C2CFBDD3A2365997A7F12D8EF0437BEAB347C8E --from val --home=$HOME/.onomy --keyring-backend test --chain-id onomy-mainnet-1 --fees 30stake --gas 300000 -y



onomyd tx vaults create-vault 15000000000000000000000anom 50000000fxUSD --from val2 --home=$HOME/.onomy --keyring-backend test --chain-id onomy-mainnet-1 --fees 30stake --gas 300000 -y

onomyd tx vaults create-vault 125000000000000000000anom 50000000fxJPY --from val2 --home=$HOME/.onomy --keyring-backend test --chain-id onomy-mainnet-1 --fees 30stake --gas 300000 -y

onomyd tx vaults create-vault 15000000000000000000000anom 50000000fxEUR --from val2 --home=$HOME/.onomy --keyring-backend test --chain-id onomy-mainnet-1 --fees 30stake --gas 300000 -y

onomyd tx psm swap 50000000ibc/91B26889D009D6C4F7D3C62244521B67C27D42D60E0517681FA6C39D4078DA28 fxUSD --from val2 --home=$HOME/.onomy --keyring-backend test --chain-id onomy-mainnet-1 --fees 30stake --gas 300000 -y

onomyd tx psm swap 50000000fxUSD ibc/91B26889D009D6C4F7D3C62244521B67C27D42D60E0517681FA6C39D4078DA28 --from val2 --home=$HOME/.onomy --keyring-backend test --chain-id onomy-mainnet-1 --fees 30stake --gas 300000 -y

onomyd tx vaults create-vault 12500000ibc/C4CFF46FD6DE35CA4CF4CE031E643C8FDC9BA4B99AE598E9B0ED98FE3A2319F9 50000000fxUSD --from val2 --home=$HOME/.onomy --keyring-backend test --chain-id onomy-mainnet-1 --fees 30stake --gas 300000 -y

onomyd tx oracle set-price ATOM 5 --from val --home=$HOME/.onomy --keyring-backend test --chain-id onomy-mainnet-1 --fees 30stake --gas 300000 -y

onomyd tx auction bid 0 15000000fxUSD 1.2 --from val2 --home=$HOME/.onomy --keyring-backend test --chain-id onomy-mainnet-1 --fees 30stake --gas 300000 -y

onomyd tx auction bid 0 60000000fxUSD 1.0 --from val2 --home=$HOME/.onomy --keyring-backend test --chain-id onomy-mainnet-1 --fees 30stake --gas 300000 -y

onomyd tx oracle set-price ATOM 8 --from val --home=$HOME/.onomy --keyring-backend test --chain-id onomy-mainnet-1 --fees 30stake --gas 300000 -y

onomyd tx vaults create-vault 12500000ibc/C4CFF46FD6DE35CA4CF4CE031E643C8FDC9BA4B99AE598E9B0ED98FE3A2319F9 50000000fxUSD --from val2 --home=$HOME/.onomy --keyring-backend test --chain-id onomy-mainnet-1 --fees 30stake --gas 300000 -y

onomyd tx oracle set-price ATOM 5 --from val --home=$HOME/.onomy --keyring-backend test --chain-id onomy-mainnet-1 --fees 30stake --gas 300000 -y

onomyd tx auction bid 1 60000000fxUSD 1.0 --from val2 --home=$HOME/.onomy --keyring-backend test --chain-id onomy-mainnet-1 --fees 30stake --gas 300000 -y

onomyd tx bank send onomy1w7f3xx7e75p4l7qdym5msqem9rd4dyc4y47xsd onomy1g9v3zjt6rfkwm4s8sw9wu4jgz9me8pn2ygn94a  60000000stake --from val --home=$HOME/.onomy --keyring-backend test --chain-id onomy-mainnet-1 --fees 30stake --gas 300000 -y


onomyd tx auction bid 2 60000000fxUSD 1.0 --from validator3 --keyring-backend=test  --home=$HOME/.onomyd/validator3 --chain-id onomy-mainnet-1 --fees 30stake --gas 300000 -y