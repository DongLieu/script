set -e

# always returns true so set -e doesn't exit if it is not running.
killall cometbft || true
rm -rf $HOME/.cometbft/

cometbft init

CONFIG=$HOME/.cometbft/config/config.toml

sed -i -E 's|prometheus = false|prometheus = true|g' $CONFIG


# tmux new -s valCometbft -d cometbft node --proxy_app=kvstore


# sleep 7
# # check status
# curl http://127.0.0.1:26657/status

# curl -s localhost:26657/status | jq '.'
# # send tx
# curl -s 'localhost:26617/broadcast_tx_commit?tx="abcd"' | jq '.'
# # check
# curl -s 'localhost:26617/abci_query?data="abcd"' | jq '.'
# # send with key and value
# curl -s 'localhost:26657/broadcast_tx_commit?tx="name=sat2ddi"' | jq '.'
# # qurry to key
# curl -s 'localhost:26617/abci_query?data="name"' | jq '.'