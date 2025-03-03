sleep 7
onomyd tx gov submit-proposal  /Users/donglieu/script/onomy/upgarde-reserve/updates-oracle-params.json --keyring-backend=test  --home=$HOME/.onomy --from val -y --chain-id onomy-mainnet-1 --fees 30stake --gas 300000

sleep 7
onomyd tx gov vote 36 yes  --from val --keyring-backend test --home ~/.onomy --chain-id onomy-mainnet-1 -y --fees 20stake


onomyd tx gov submit-proposal  /Users/donglieu/script/onomy/upgarde-reserve/updates-oracle-params.json --keyring-backend=test  --home=$HOME/.onomy --from val -y --chain-id testing-1 --fees 30stake --gas 300000


onomyd tx bank multi-send $( onomyd keys show validator1 --home=$HOME/.onomyd/validator1  --keyring-backend test -a) $( onomyd keys show test1 --home=$HOME/.onomyd/validator1  --keyring-backend test -a) $( onomyd keys show test2 --home=$HOME/.onomyd/validator1  --keyring-backend test -a) $( onomyd keys show test3 --home=$HOME/.onomyd/validator1  --keyring-backend test -a) 10000stake,100000000ibc/C4CFF46FD6DE35CA4CF4CE031E643C8FDC9BA4B99AE598E9B0ED98FE3A2319F9,100000000000ibc/91B26889D009D6C4F7D3C62244521B67C27D42D60E0517681FA6C39D4078DA28,100000000000ibc/F14D29B8CF730AEE5D65141F1C2CFBDD3A2365997A7F12D8EF0437BEAB347C8E,1500000000000000000000000anom --home=$HOME/.onomyd/validator1 --keyring-backend test --fees 50stake --gas 500000 --chain-id onomy-mainnet-1 -y



onomyd tx bank multi-send $( onomyd keys show validator1 --home=$HOME/.onomyd/validator1  --keyring-backend test -a) $( onomyd keys show test1 --home=$HOME/.onomyd/validator1  --keyring-backend test -a) $( onomyd keys show test2 --home=$HOME/.onomyd/validator1  --keyring-backend test -a) $( onomyd keys show test3 --home=$HOME/.onomyd/validator1  --keyring-backend test -a) 75750000000000fxJPY --home=$HOME/.onomyd/validator1 --keyring-backend test --fees 50stake --gas 500000 --chain-id onomy-mainnet-1 -y
