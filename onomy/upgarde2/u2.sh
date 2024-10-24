sleep 7
onomyd tx gov submit-proposal  /Users/donglieu/script/onomy/upgarde2/upgrade2_1_1.json --keyring-backend=test --home=$HOME/.onomy --from onomy1wa3u4knw74r598quvzydvca42qsmk6jrc6uj7m -y --chain-id onomy-mainnet-1 --fees 20stake
sleep 7

onomyd tx gov vote 34 yes  --from val --keyring-backend test --home=$HOME/.onomy  -y --fees 20stake --chain-id onomy-mainnet-1
sleep 7
onomyd tx gov vote 33 yes  --from val2 --keyring-backend test --home=$HOME/.onomy -y --fees 20stake --chain-id onomy-mainnet-1

onomyd tx gov submit-proposal /Users/donglieu/102024/onomy/script/proposal-1.json --home=$HOME/.onomy  --from val --keyring-backend test --fees 20stake --chain-id onomy-mainnet-1 -y


onomyd tx vaults create-vault 1250000000anom 50000000nomUSD --from val --home=$HOME/.onomy --keyring-backend test --fees 20stake --chain-id onomy-mainnet-1  -y