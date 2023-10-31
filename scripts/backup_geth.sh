#!/usr/bin/env bash
docker cp opgeth:/opstack/op-geth/datadir/geth/ .
rm -rf geth/nodekey
tar -zcvf geth.tar.gz geth