#!/bin/bash
#heathcheck opgeth, and run

code=$(curl -s -o /dev/null -w "%{http_code}" 'http://opgeth:8551')
echo "Code: "
echo $code

echo $L1_CHAIN_ID
echo $L2_CHAIN_ID

if [ "$code" = 401 ]; then
    echo "Genesis file found. Starting Opnode."
    cd /opstack/optimism/op-node
    ./bin/op-node \
        --l2=http://opgeth:8551 \
        --l2.jwt-secret=./jwt.txt \
        --pprof.enabled \
        --sequencer.enabled \
        --sequencer.l1-confs=3 \
        --p2p.sequencer.key=$SEQ_KEY \
        --verifier.l1-confs=3 \
        --rollup.config=./rollup.json \
        --rpc.addr=0.0.0.0 \
        --rpc.port=8547 \
        --rpc.enable-admin \
        --l1=$L1_RPC \
        --l1.rpckind=$RPC_KIND\
        --p2p.listen.ip=0.0.0.0 \
        --p2p.listen.tcp=9003 \
        --p2p.listen.udp=9003
else
    echo "Node cannot detect OPGeth... Waiting..."
fi