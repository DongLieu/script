# !/bin/bash
# # # screen -r mesh1
# # # screen -r mesh2
# killall hermes || true
killall meshd || true
# deploy chain 1
./mesh/testibc/chain1.sh
# deploy chain 2
./mesh/testibc/chain2.sh
sleep 7
./mesh/testibc/instantiate.sh
sleep 7
# run relayer
./mesh/testibc/hermes_bootstrap.sh
sleep 7
# instantiate contract consumer and provider


# sau khi ibc thi mesh_external_staking.wasm lay price mesh_osmosis_price_provider.wasm and mesh_remote_price_feed.wasm



#2: predict auto blanket pole ahead rebuild awake motor depart memory garlic also bid select detail elder capital frame cereal position oil ride measure volcano
#1: cabbage receive pledge grocery world desk culture chimney wheel ship beauty toward east second inch surprise shine winter narrow ketchup road conduct wear above
# nano /Users/donglieu/.hermes/mnemonic1
# meshd tx bank send $val2 $test2 100000stake --home=$home --chain-id $chainid --keyring-backend test --fees 10stake -y --node tcp://127.0.0.1:26654
# terra tx ibc-transfer transfer transfer channel-0 terra1nc5tatafv6eyq7llkr2gv50ff9e22mnf70qgjlv737ktmt4eswrquka9l6 10000000uluna --from=terra1tr78d49qlunw396vr6qmppdj755m4stl476qdp --memo {"wasm":{"contract":"terra1nc5tatafv6eyq7llkr2gv50ff9e22mnf70qgjlv737ktmt4eswrquka9l6","msg": {"increment": {}} }} --chain-id=terra-test-b --yes --keyring-backend=test --log_format=json --gas=4000000 --fees=0uluna

# meshd tx ibc-transfer transfer transfer channel-0 $(meshd keys show val --keyring-backend test -a --home=$HOME/.meshd/chain1) 10000stake --from val --chain-id chain-2 --home $HOME/.meshd/chain2 --yes --keyring-backend test --gas 6000000 --fees 1stake --node tcp://127.0.0.1:26654

# meshd q tx AE13CC7D3A660A36E89BC66FE4D6516FF4ED8679DE8D31F116AC5EFB6A3986F4 --node tcp://127.0.0.1:26654

# meshd q bank balances $(meshd keys show val -a --keyring-backend test --home $HOME/.meshd/chain1)

# meshd q ibc 
#  meshd q ibc channel channels --node tcp://127.0.0.1:26654