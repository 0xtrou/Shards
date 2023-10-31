#!/bin/bash
if ! [ -f "/opstack/op-geth/genesis.json" ] && ! [ -f "/opstack/optimism/op-node/rollup.json" ]; then
    echo "Preparing files..."
    cp -R /opstack-temp/* /opstack/

    mkdir /opstack/op-geth/datadir

    if [ -f "/assets/genesis.json" ] && [ -f "/assets/rollup.json" ]; then
      cp /assets/genesis.json /opstack/op-geth
      cp /assets/rollup.json /opstack/optimism/op-node
    else
      echo "Required assets not found, stop."
      exit 0
    fi

    # Generate the L2 config files
    cd /opstack/optimism/op-node
    openssl rand -hex 32 > jwt.txt
    cp jwt.txt /opstack/op-geth

    # Initialize op-geth
    cd /opstack/op-geth
    echo "pwd" > datadir/password
    build/bin/geth init --datadir=datadir genesis.json

    if [ -f "/assets/geth.tar.gz" ]; then
        echo "Found snapshot, copying..."
        rm -rf /opstack/op-geth/datadir/geth
        cp /assets/geth.tar.gz /opstack/op-geth/datadir
        tar xvf /opstack/op-geth/datadir/geth.tar.gz
        rm -rf geth.tar.gz
    fi

    echo "Build Successful ✅"
    exit 0
else
    echo "Found genesis file. Not rebuilding."
    exit 0
fi