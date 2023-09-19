#!/usr/bin/env bash

echo "Cleaning up..."

rm -rf /tmp/besu /tmp/teku
rm -f beku-genesis.ssz
sed -i'' -e "s/\"shanghaiTime\": .*,/\"shanghaiTime\": 0,/" execution-genesis.json
sed -i'' -e "s/\"cancunTime\": .*,/\"cancunTime\": 0,/" execution-genesis.json

rm -f execution-genesis.json-*
rm -f genesis-header.json
