#!/usr/bin/env bash
docker cp opgeth:/opstack/op-get/datadir/geth/ .
tar -zcvf geth.tar.gz geth