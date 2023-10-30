#!/usr/bin/env bash

# Stop the node and geth
docker compose up -d

sleep 2

# Stop the batcher
curl -d '{"id":0,"jsonrpc":"2.0","method":"admin_startBatcher","params":[]}' \
    -H "Content-Type: application/json" http://localhost:8548 | jq
