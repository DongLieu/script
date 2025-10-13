# snapshot -> data
lz4 -c -d /Users/donglieu/Downloads/bitcanna_21615190.tar.lz4 | tar -x -C $HOME/.bcna/

# genesis.json
curl -s https://snapshots.polkachu.com/genesis/bitcanna/genesis.json > $HOME/.bcna/config/genesis.json

# path binary
cd /Users/donglieu/1025/bitcanna/bcna/
go install ./...
chaind=bcnad

$chaind init test --chain-id testing-1


/Users/donglieu/1025/cosmos-tooling/test-data/