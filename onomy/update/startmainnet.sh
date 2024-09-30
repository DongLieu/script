killall onomyd || true
sleep 2
rm -rf $HOME/.onomy
cp -r $HOME/1/.onomy $HOME/

onomyd start