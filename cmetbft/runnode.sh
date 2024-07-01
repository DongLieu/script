#!/bin/bash
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
# curl -s localhost:26657/status
# # send tx
# curl -s 'localhost:26657/broadcast_tx_commit?tx="abcd"'
# # check
# curl -s 'localhost:26657/abci_query?data="abcd"'
# curl -s 'localhost:26657/abci_query?data="abcd"' | jq
# # send with key and value
# curl -s 'localhost:26657/broadcast_tx_commit?tx="name=satoshi"'| jq
# # qurry to key
# curl -s 'localhost:26657/abci_query?data="name"'

"Stopping peer for error" err=EOF module=p2p peer="Peer{MConn{15.235.115.152:12200} 529804da16ed49ac029f23bffecb68cd993453a5 out}"
May 27 11:04:33 Soroban2 bash[2984555]: time="2024-05-27T11:04:33+02:00" level=info msg="service stop" fields.msg="Stopping Peer service" impl="Peer{MConn{15.235.115.152:12200} 529804da16ed49ac029f23bffecb68cd993453a5 out}" module=p2p peer="529804da16ed49ac029f23bffecb68cd993453a5@15.235.115.152:12200"
May 27 11:04:33 Soroban2 bash[2984555]: time="2024-05-27T11:04:33+02:00" level=info msg="Reconnecting to peer" addr="529804da16ed49ac029f23bffecb68cd993453a5@15.235.115.152:12200" module=p2p
May 27 11:04:33 Soroban2 bash[2984555]: time="2024-05-27T11:04:33+02:00" level=info msg="service start" fields.msg="Starting Peer service" impl="Peer{MConn{141.164.38.26:12200} ab0762cd6113f90b620ecb4aaa7cebbe3114f44f out}" module=p2p peer="ab0762cd6113f90b620ecb4aaa7cebbe3114f44f@141.164.38.26:12200"
May 27 11:04:33 Soroban2 bash[2984555]: time="2024-05-27T11:04:33+02:00" level=info msg="service start" fields.msg="Starting MConnection service" impl="MConn{141.164.38.26:12200}" module=p2p peer="ab0762cd6113f90b620ecb4aaa7cebbe3114f44f@141.164.38.26:12200"
May 27 11:04:33 Soroban2 bash[2984555]: time="2024-05-27T11:04:33+02:00" level=info msg="Connection is closed @ recvRoutine (likely by the other side)" conn="MConn{141.164.38.26:12200}" module=p2p peer="ab0762cd6113f90b620ecb4aaa7cebbe3114f44f@141.164.38.26:12200"
May 27 11:04:33 Soroban2 bash[2984555]: time="2024-05-27T11:04:33+02:00" level=info msg="service stop" fields.msg="Stopping MConnection service" impl="MConn{141.164.38.26:12200}" module=p2p peer="ab0762cd6113f90b620ecb4aaa7cebbe3114f44f@141.164.38.26:12200"
May 27 11:04:33 Soroban2 bash[2984555]: time="2024-05-27T11:04:33+02:00" level=info msg="notifying bugsnag: Stopping peer for error"
May 27 11:04:33 Soroban2 bash[2984555]: time="2024-05-27T11:04:33+02:00" level=info msg="bugsnag.Notify: not notifying in local"
