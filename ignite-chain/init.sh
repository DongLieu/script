initcontents=$(cat /Users/donglieu/script/ignite-chain/init.json)

# echo $initcontents

dozozod tx accounts init multisig "$initcontents" --chain-id testing-1 --keyring-backend test  --from val