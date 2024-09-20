#!/bin/bash
set -xeu

chain=$1
home=$2
valset_path=$3
repo_path=$4
version=$5

git clone --depth 1 --branch $version + $repo_path
cd $chain

git clone 
