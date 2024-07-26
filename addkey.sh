#!/bin/bash
set -xeu

home1=$HOME/.meshd/chain1
chainid1=chain-1
home2=$HOME/.meshd/chain2
chainid2=chain-2

test1=$(meshd keys show test1  --keyring-backend test -a --home=$home1)
val1=$(meshd keys show val  --keyring-backend test -a --home=$home1)
test2=$(meshd keys show test1  --keyring-backend test -a --home=$home2)
val2=$(meshd keys show val  --keyring-backend test -a --home=$home2)

# meshd tx wasm instantiate 1 '{"denom": "stake", "local_staking": {"code_id": 3, "msg": "eyJkZW5vbSI6ICJzdGFrZSIsICJvd25lciI6ICJtZXNoMTBkMDd5MjY1Z21tdXZ0NHowdzlhdzg4MGpuc3I3MDBqczJsam5nIiwgInByb3h5X2NvZGVfaWQiOiAyLCAidmFsaWRhdG9yIjogIm1lc2h2YWxvcGVyMTg5OHFnODJjeTJjcWozczZnYTA1aDl1ang5N2R2cnZqeGt3eDl3IiwgInNsYXNoX3JhdGlvX2RzaWduIjogIjAuMjAiLCAic2xhc2hfcmF0aW9fb2ZmbGluZSI6ICIwLjEwIiB9"}}' --label contract-vault --admin $val2 --from $val2 --home=$HOME/.meshd/chain2  --chain-id chain-2 --keyring-backend test --node tcp://127.0.0.1:26654 --fees 1stake -y --gas 3059023 

meshd tx wasm instantiate 4 '{"remote_contact": {"connection_id":"connection-0", "port_id":"wasm.mesh1qg5ega6dykkxc307y25pecuufrjkxkaggkkxh7nad0vhyhtuhw3stmd2jl"}, "denom": "stake", "vault": "mesh14hj2tavq8fpesdwxxcu44rty3hh90vhujrvcmstl4zr3txmfvw9sysl6kf", "unbonding_period": 1814400, "rewards_denom": "stake", "slash_ratio": { "double_sign": "0.20", "offline": "0.10" }  }' --label contract-externalstaking --admin $val2 --from $val2 --home=$HOME/.meshd/chain2  --chain-id chain-2 --keyring-backend test --node tcp://127.0.0.1:26654 --fees 1stake -y --gas 3059023 
