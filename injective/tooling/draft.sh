# data
lz4 -c -d /Users/donglieu/Downloads/injective_138281696.tar.lz4 | tar -x -C $HOME/.injectived/

# genesis.json
curl -s https://snapshots.polkachu.com/genesis/injective/genesis.json > $HOME/.injectived/config/genesis.json


injectived tx gov submit-proposal  /Users/donglieu/script/injective/tooling/draft_proposal.json --keyring-backend=test  --home=$HOME/.injectived --from inj1txstwnlh9urgh5kr6y5m8j30wp9qra2x7kv52j -y --chain-id injective-1 --fees 64260320000000inj --gas 401627


injectived tx bank send inj1txstwnlh9urgh5kr6y5m8j30wp9qra2x7kv52j inj1982s57g5kadu2v4ygapne9vj0t7p9d59acsp49 100000inj --keyring-backend=test  --home=$HOME/.injectived --from inj1txstwnlh9urgh5kr6y5m8j30wp9qra2x7kv52j -y --chain-id injective-1 --fees 50inj --gas 401627