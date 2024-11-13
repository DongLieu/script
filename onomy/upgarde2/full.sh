
killall onomyd || true
sleep 2

# # onomy mainnet đang start ở thư muc --home: $HOME/1/.onomy
# # chuyen data tu mainnet sang deffau
rm -rf $HOME/.onomy
cp -r $HOME/1/.onomy $HOME/

# create testnet from mainnet state with acount from mnemonic1,2,3,4,5,6 or any acounts. Testnet create mint bond denom to accounts
sed -i.bak 's/^persistent_peers = ".*"/persistent_peers = ""/' $HOME/.onomy/config/config.toml 


update_test_genesis () {
    # EX: update_test_genesis '.consensus_params["block"]["max_gas"]="100000000"'
    cat $HOME/.onomy/config/genesis.json | jq "$1" > tmp.json && mv tmp.json $HOME/.onomy/config/genesis.json
}

# update_test_genesis '.app_state["gov"]["deposit_params"]["max_deposit_period"] = "15s"'
update_test_genesis '.app_state["gov"]["voting_params"]["voting_period"] = "15s"'
update_test_genesis '.app_state["gov"]["params"]["voting_period"] = "15s"'

account="onomy1wa3u4knw74r598quvzydvca42qsmk6jrc6uj7m,onomy1w7f3xx7e75p4l7qdym5msqem9rd4dyc4y47xsd,onomy1g9v3zjt6rfkwm4s8sw9wu4jgz9me8pn2ygn94a,onomy1qvuhm5m644660nd8377d6l7yz9e9hhm9rd0sqr,onomy16gjg8p5fedy48wf403jwmz2cxlwqtkqlk3ptmx,onomy19wtdcnkcz7pcrvu68du2y8xwh8quw6l7s0qc0v"

# screen -S onomy0 -t onomy0 -d -m 
onomyd  in-place-testnet onomy-mainnet-1  onomyvaloper1wa3u4knw74r598quvzydvca42qsmk6jrya79zd --accounts-to-fund=$account --home=$HOME/.onomy --skip-confirmation

# sleep 7
# onomyd tx gov submit-proposal  /Users/donglieu/script/onomy/upgarde2/upgrade2_1_0.json --keyring-backend=test --home=$HOME/.onomy --from onomy1wa3u4knw74r598quvzydvca42qsmk6jrc6uj7m -y --chain-id onomy-mainnet-1 --fees 20stake
# sleep 7

# onomyd tx gov vote 32 yes  --from val --keyring-backend test --home=$HOME/.onomy --chain-id testing-1 -y --fees 20stake --chain-id onomy-mainnet-1
# sleep 7
# onomyd tx gov vote 32 yes  --from val2 --keyring-backend test --home=$HOME/.onomy --chain-id testing-1 -y --fees 20stake --chain-id onomy-mainnet-1
