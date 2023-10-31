#!/usr/bin/env bash
# Stop the node and geth
docker compose stop opbatcher
docker compose stop opproposer
docker compose stop opnode
docker compose stop opgeth

# Removed old containers
docker compose rm -f opnode
docker compose rm -f opgeth

