#!/usr/bin/env bash

echo "Cleaning up..."

rm -rf /tmp/besu /tmp/teku
rm -f beku-genesis.ssz
rm -f ./besu/execution-genesis.json
rm -f ./teku/genesis-header.json
