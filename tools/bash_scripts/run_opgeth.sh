#!/bin/bash


if [ ! -f "/opstack/op-geth/genesis.json" ]; then
    echo "Genesis file not found... Waiting ..."
    exit 666
else
    echo "Found genesis file. Starting Geth."
    cd /opstack/op-geth
    ./build/bin/geth \
        --datadir=./datadir \
        --http \
        --http.corsdomain="*" \
        --http.vhosts="*" \
        --http.addr=0.0.0.0 \
        --http.api=web3,debug,eth,txpool,net,engine \
        --ws \
        --ws.addr=0.0.0.0 \
        --ws.port=8546 \
        --ws.origins="*" \
        --ws.api=debug,eth,txpool,net,engine \
        --syncmode=full \
        --gcmode=archive \
        --nodiscover \
        --maxpeers=0 \
        --networkid=$L2_CHAIN_ID \
        --authrpc.vhosts="*" \
        --authrpc.addr=0.0.0.0 \
        --authrpc.port=8551 \
        --rollup.disabletxpoolgossip=true \
        --password=./datadir/password \
        --authrpc.jwtsecret=./jwt.txt \
        --bootnodes=$GETH_BOOTNODES \
        --rollup.disabletxpoolgossip=true \
        --miner.gaslimit=150000000 \
        --rpc.gascap=150000000
fi