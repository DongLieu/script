HOME_FORK=$HOME/.injective-tooling

cd /Users/donglieu/1125/inj/injective-core
go install ./...

injectived start --home=$HOME_FORK 