killall onomyd || true
onomyd snapshots export --home=$HOME/.onomyd-tooling//validator4
# query
snapshots=$(onomyd snapshots list --home=$HOME/.onomyd-tooling/validator4)
echo $snapshots > /Users/donglieu/script/onomy/tooling/snapshot/snapshot-list.txt
height=$(python3 /Users/donglieu/script/onomy/tooling/snapshot/snapshot-get-height.py /Users/donglieu/script/onomy/tooling/snapshot/snapshot-list.txt height)
format=$(python3 /Users/donglieu/script/onomy/tooling/snapshot/snapshot-get-height.py /Users/donglieu/script/onomy/tooling/snapshot/snapshot-list.txt format)
path_file=/Users/donglieu/script/onomy/tooling/snapshot/snapshot-onomy-$height.tar.lz4

# Dump the snapshot as portable archive format
onomyd snapshots dump $height $format -o $path_file --home=$HOME/.onomyd-tooling/validator4
# /Users/donglieu/script/onomy/tooling/snapshot/start_nodes.sh