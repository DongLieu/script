killall onomyd || true

screen -S onomy1 -t onomy1 -d -m onomyd start --home=$HOME/.onomyd-tooling/validator1
screen -S onomy2 -t onomy2 -d -m onomyd start --home=$HOME/.onomyd-tooling/validator2
screen -S onomy3 -t onomy3 -d -m onomyd start --home=$HOME/.onomyd-tooling/validator3
screen -S onomy3 -t onomy3 -d -m onomyd start --home=$HOME/.onomyd-tooling/validator4