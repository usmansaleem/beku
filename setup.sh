#!/bin/bash
set -euo pipefail

#export LOG4J_CONFIGURATION_FILE=./log4j2-test.xml

SCRIPTDIR="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

source $SCRIPTDIR/config.sh

if [ ! -d "$TEKU_HOME" ]
then
    echo "Set TEKU_HOME to the teku installation directory in config.sh ..."
    exit 1
fi

GENESIS="${SCRIPTDIR}/beku-genesis.ssz"
rm -rf /tmp/teku
rm -rf "${GENESIS}"

# Genesis time start in 1 minutes (60 seconds)
export GENESIS_TIME=$(($(date +%s) + 60))

# - 24 seconds per epoch, so epoch 1 for capella
SHANGHAI=$(($GENESIS_TIME + 24))
sed  -i '' -e "s/\"shanghaiTime\": .*,/\"shanghaiTime\": $SHANGHAI,/" execution-genesis.json

# - 24 seconds per epoch, so epoch 2 for cancun/deneb
CANCUN=$(($GENESIS_TIME + 48))
sed  -i '' -e "s/\"cancunTime\": .*,/\"cancunTime\": $CANCUN,/" execution-genesis.json

echo "********************"
echo "TEKU Genesis : $GENESIS_TIME"
echo "BESU Shanghai: $SHANGHAI"
echo "BESU Cancun/Deneb: $CANCUN"
echo "********************"

$TEKU_HOME/bin/teku genesis mock --output-file "${GENESIS}" --network config.yaml --validator-count 256 --genesis-time $GENESIS_TIME

