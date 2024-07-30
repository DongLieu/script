#!/bin/bash
set -xeu
sudo apt-get install expect
brew install expect

app=$1
home=$2


m=$(cat ./typeskey/mnemonic2)
n=$(cat ./typeskey/mnemonic1)


./typeskey/addkeyscript.exp "$n" "$home" "$app" "val1"
./typeskey/addkeyscript.exp "$m" "$home" "$app" "val2"