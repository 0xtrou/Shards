#!/usr/bin/env bash
docker cp opgeth:/opstack/op-geth/datadir/geth/ .
tar -zcvf geth.tar.gz geth