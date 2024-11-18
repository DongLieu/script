


killall onomyd || true
sleep 2

# # onomy mainnet đang start ở thư muc --home: $HOME/1/.onomy
# # chuyen data tu mainnet sang deffau
rm -rf $HOME/.onomy
cp -r $HOME/1/.onomy $HOME/

# create testnet from mainnet state with acount from mnemonic1,2,3,4,5,6 or any acounts. Testnet create mint bond denom to accounts
sed -i.bak 's/^persistent_peers = ".*"/persistent_peers = ""/' $HOME/.onomy/config/config.toml 

account="onomy1wa3u4knw74r598quvzydvca42qsmk6jrc6uj7m,onomy1w7f3xx7e75p4l7qdym5msqem9rd4dyc4y47xsd,onomy1g9v3zjt6rfkwm4s8sw9wu4jgz9me8pn2ygn94a,onomy1qvuhm5m644660nd8377d6l7yz9e9hhm9rd0sqr,onomy16gjg8p5fedy48wf403jwmz2cxlwqtkqlk3ptmx,onomy19wtdcnkcz7pcrvu68du2y8xwh8quw6l7s0qc0v"

# screen -S onomy0 -t onomy0 -d -m 
onomyd  in-place-testnet onomy-mainnet-1  onomyvaloper1wa3u4knw74r598quvzydvca42qsmk6jrya79zd --accounts-to-fund=$account --home=$HOME/.onomy --skip-confirmation
# onomyd  in-place-testnet onomy-mainnet-1  onomyvaloper1wa3u4knw74r598quvzydvca42qsmk6jrya79zd --accounts-to-fund=onomy1wa3u4knw74r598quvzydvca42qsmk6jrc6uj7m --skip-confirmation --home=$HOME/.onomy 
# # onomyd testnet onomy-mainnet-1 cosmosvaloper1w7f3xx7e75p4l7qdym5msqem9rd4dyc4mq79dm --home $HOME/.onomy --accounts-to-fund="cosmos1f7twgcq4ypzg7y24wuywy06xmdet8pc4473tnq,cosmos1qvuhm5m644660nd8377d6l7yz9e9hhm9evmx3x"

# echo "================start 3 node==========================="
# # # start 3 node 
# sleep 7
# /Users/donglieu/script/onomy/update/create.sh

# echo "================stake 3 node==========================="
# # # # stake 3 node
# sleep 7
# /Users/donglieu/script/onomy/update/stake.sh

# echo "================gov upgrade==========================="
# # # # submit gov upgrade
# sleep 7
# /Users/donglieu/script/onomy/update/gov_upgrade.sh

#  onomyd q staking unbonding-delegations onomy1g6krv8347dvh5rq86g3wrke0ukkacf2s92elwf
# pagination:
#   next_key: null
#   total: "0"
# unbonding_responses:
# - delegator_address: onomy1g6krv8347dvh5rq86g3wrke0ukkacf2s92elwf
#   entries:
#   - balance: "2715114236606829960"
#     completion_time: "2024-09-28T22:35:01.838527874Z"
#     creation_height: "9419210"
#     initial_balance: "2715114236606829960"
#     unbonding_id: "3653"
#     unbonding_on_hold_ref_count: "1"
#   validator_address: onomyvaloper1fewecfptznhtdvxe5sqw2m6axyes6kst384l

# onomyd q bank balances onomy1g6krv8347dvh5rq86g3wrke0ukkacf2s92elwf
# balances:
# - amount: "2956175855175122970"
#   denom: anom
# - amount: "15272724992977203"
#   denom: ibc/2C41B5207D564200FE5D6FA451C588BF050D01B3639900E63C38643B75A0A502
# - amount: "48398735713204230"
#   denom: ibc/478DDDC4677472DB6135000FA69AD268FDE85671A1FE59F0846D7D16D4D947A8
# pagination:
#   next_key: null
#   total: "0"

# ==================================================================================================


# onomyd q staking unbonding-delegations onomy17qadvks5g8ywxsw34s2z6ltqfxkq4mecufwx4g
# pagination:
#   next_key: null
#   total: "0"
# unbonding_responses:
# - delegator_address: onomy17qadvks5g8ywxsw34s2z6ltqfxkq4mecufwx4g
#   entries:
#   - balance: "473050000000000000"
#     completion_time: "2024-09-22T05:07:58.554551863Z"
#     creation_height: "9321083"
#     initial_balance: "473050000000000000"
#     unbonding_id: "3618"
#     unbonding_on_hold_ref_count: "1"


#   - balance: "500000000000000000000"
#     completion_time: "2024-10-06T21:19:36.152222457Z"
#     creation_height: "9534684"
#     initial_balance: "500000000000000000000"
#     unbonding_id: "3675"
#     unbonding_on_hold_ref_count: "1"


#   - balance: "4500000010000000000000"
#     completion_time: "2024-10-07T13:37:29.998082966Z"
#     creation_height: "9544551"
#     initial_balance: "4500000010000000000000"
#     unbonding_id: "3676"
#     unbonding_on_hold_ref_count: "1"


#   - balance: "100000000000"
#     completion_time: "2024-09-28T19:03:21.712961922Z"
#     creation_height: "9417068"
#     initial_balance: "100000000000"
#     unbonding_id: "3652"
#     unbonding_on_hold_ref_count: "1"
#   validator_address: onomyvaloper1n426r3jk58la94mhlnufq57gllt2jaz76qhm6h



# onomyd q bank balances onomy17qadvks5g8ywxsw34s2z6ltqfxkq4mecufwx4g
# balances:
# - amount: "2711539249928891876593"
#   denom: anom
# 7.712012

# ==================================================================================================

# balances:
# - amount: "2714377550028891876593"