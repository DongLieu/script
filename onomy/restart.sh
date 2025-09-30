python3 /Users/donglieu/script/onomy/main.py /Users/donglieu/.onomyd/validator1/config/priv_validator_key.json Twsc4LmID4wKDOamLn7nOeyIDuqEFOsLVxgHS/26g0c/uIviexqK0dHl/IbbL6TQE6mC9y5c7V3HZy6jn8o/HA==
python3 /Users/donglieu/script/onomy/main.py /Users/donglieu/.onomyd/validator2/config/priv_validator_key.json Twsc4LmID4wKDOamLn7nOeyIDuqEFOsLVxgHS/26g0c/uIviexqK0dHl/IbbL6TQE6mC9y5c7V3HZy6jn8o/HA==
python3 /Users/donglieu/script/onomy/main.py /Users/donglieu/.onomyd/validator3/config/priv_validator_key.json Twsc4LmID4wKDOamLn7nOeyIDuqEFOsLVxgHS/26g0c/uIviexqK0dHl/IbbL6TQE6mC9y5c7V3HZy6jn8o/HA==

screen -S onomy1 -t onomy1 -d -m onomyd start --home=$HOME/.onomyd/validator1
screen -S onomy2 -t onomy2 -d -m onomyd start --home=$HOME/.onomyd/validator2
screen -S onomy3 -t onomy3 -d -m onomyd start --home=$HOME/.onomyd/validator3
onomyd start --home=$HOME/.onomyd/validator4