#!/bin/bash

# Find the Addresss of the L2 OutPutOracle
if [ "$L2OO_ADDRESS" = "" ]; then
    echo "L2OO_ADDRESS not set. Finding L2OO_ADDR"
    L2OO_ADDRESS=$(cat /opstack/optimism/packages/contracts-bedrock/deployments/getting-started/L2OutputOracleProxy.json | jq -r '.address')
    echo $L2OO_ADDRESS
else
    echo "L2OO_ADDRESS already set. Using L2OO_ADDR"
    echo $L2OO_ADDRESS
fi

code=$(curl -s -o /dev/null -w "%{http_code}" 'http://opnode:8547')
echo "OPProposer Code: "
echo $code

if [ "$code" = 200 ]; then
    echo "Proposer - Opnode:8547 200. Launching Proposer "
    cd /opstack/optimism/op-proposer
    ./bin/op-proposer \
        --poll-interval 12s \
        --rpc.port 8560 \
        --rollup-rpc http://opnode:8547 \
        --l2oo-address $L2OO_ADDRESS \
        --private-key $PROPOSER_KEY \
        --l1-eth-rpc $L1_RPC
else
    echo "Proposer cannot detect OPNode... Waiting..."
fi