#!/usr/bin/env bash

# Stop the batcher
curl -d '{"id":0,"jsonrpc":"2.0","method":"admin_stopBatcher","params":[]}' \
    -H "Content-Type: application/json" http://localhost:8548 | jq

# Stop the node and geth
docker compose stop opnode
docker compose stop opgeth

# Removed old containers
docker compose rm opnode
docker compose rm opgeth

