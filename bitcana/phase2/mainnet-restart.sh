cd /Users/donglieu/1025/bitcanna/1/bcna
go install ./...

screen -S bcna2 -t bcna2 -d -m bcnad start --home=$HOME/.bcnad/validator2
screen -S bcna3 -t bcna3 -d -m bcnad start --home=$HOME/.bcnad/validator3
screen -S bcna4 -t bcna4 -d -m bcnad start --home=$HOME/.bcnad/validator4