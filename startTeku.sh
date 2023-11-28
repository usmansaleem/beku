#!/bin/bash
set -euo pipefail

SCRIPTDIR="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

export LOG4J_CONFIGURATION_FILE=$SCRIPTDIR/teku/log4j2-test.xml
source $SCRIPTDIR/config.sh

if [ ! -d "$TEKU_HOME" ]
then
    echo "Set TEKU_HOME to the teku installation directory in config.sh ..."
    exit 1
fi

GENESIS="${SCRIPTDIR}/beku-genesis.ssz"

if [ ! -f "$GENESIS" ]
then
  echo "Run setup.sh to generate mock genesis first"
  exit 1
fi

# before we start Teku, we need to wait for Besu to start, obtain the genesis hash and update it in genesis-header.json
${SCRIPTDIR}/teku/update-genesis-hash.sh

echo "Starting Teku"
$TEKU_HOME/bin/teku \
  --ee-endpoint http://127.0.0.1:8551 \
  --ee-jwt-secret-file="jwtsecret.txt" \
  --validators-proposer-default-fee-recipient=0xa94f5374fce5edbc8e2a8697c15331677e6ebf0b \
  --metrics-enabled=true \
  --metrics-host-allowlist="*" \
  --metrics-interface="0.0.0.0" \
  --initial-state="${GENESIS}" \
  --network=teku/config.yaml \
  --p2p-private-key-file=teku/teku.key \
  --p2p-port=1789 \
  --rest-api-enabled \
  --rest-api-docs-enabled \
  --Xstartup-target-peer-count=0 \
  --Xstartup-timeout-seconds=0 \
  --validators-external-signer-url=http://localhost:9000 \
  --validators-external-signer-public-keys=external-signer \
  --data-path /tmp/teku \
  --Xinterop-enabled=true \
  --Xinterop-number-of-validators=256 \
  --Xinterop-owned-validator-start-index=0 \
  --Xinterop-owned-validator-count=256 \
  --Xinterop-genesis-payload-header=teku/genesis-header.json

#  --Xtrusted-setup=teku/minimal-trusted-setup.txt

#    --validators-external-signer-public-keys=http://localhost:9000/publicKeys \