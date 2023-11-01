#!/usr/bin/env bash

if ! [ -f "./assets/geth.tar.gz" ]; then
    echo "Please download geth binary from https://geth.ethereum.org/downloads/ and put it in ./assets/geth.tar.gz"
    exit 1
else
    echo "Found geth binary in ./assets/geth.tar.gz"
fi

DOCKER_VOLUME=$1

if [ -z "$DOCKER_VOLUME" ]; then
    echo "Please provide docker volume path as first argument"
    exit 1
fi

echo "Initialize dummy client ..."
docker run -d --rm --name dummy -v $DOCKER_VOLUME:/opstack/ alpine tail -f /dev/null

echo "Waiting to make sure client is initialized ..."
sleep 3

echo "Copy geth binary to host ..."
docker cp ./assets/geth.tar.gz dummy:/opstack/op-geth/geth.tar.gz

echo "Start decompressing geth binary ..."
docker exec dummy tar xvf /opstack/op-geth/geth.tar.gz -C /opstack/op-geth/
docker exec dummy cp -r /opstack/op-geth/geth/ /opstack/op-geth/datadir/geth/

echo "Cleaning up ..."
docker exec dummy rm -rf /opstack/op-geth/geth.tar.gz
docker exec dummy rm -rf /opstack/op-geth/geth

echo "Stop dummy client ..."
docker rm -f dummy

echo "Done patching geth binary ✅"
