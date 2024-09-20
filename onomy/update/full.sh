

# onomy mainnet đang start ở thư muc --home: $HOME/1/2/.onomy

# Start node tesst
killall onomyd || true
rm -rf $HOME/.onomy
cp -r $HOME/1/2/.onomy $HOME/

sed -i.bak 's/^persistent_peers = ".*"/persistent_peers = ""/' $HOME/.onomy/config/config.toml 


account="onomy1wa3u4knw74r598quvzydvca42qsmk6jrc6uj7m,onomy1w7f3xx7e75p4l7qdym5msqem9rd4dyc4y47xsd,onomy1g9v3zjt6rfkwm4s8sw9wu4jgz9me8pn2ygn94a,onomy1qvuhm5m644660nd8377d6l7yz9e9hhm9rd0sqr,onomy16gjg8p5fedy48wf403jwmz2cxlwqtkqlk3ptmx,onomy19wtdcnkcz7pcrvu68du2y8xwh8quw6l7s0qc0v"

screen -S onomy0 -t onomy0 -d -m onomyd testnet onomy-mainnet-1  onomyvaloper1wa3u4knw74r598quvzydvca42qsmk6jrya79zd --accounts-to-fund=$account --home=$HOME/.onomy --skip-confirmation


# start 3 node 
sleep 7
/Users/donglieu/script/onomy/update/create.sh

# stake 3 node
sleep 7
/Users/donglieu/script/onomy/update/stake.sh

sleep 7


