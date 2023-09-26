#!/bin/bash
set -euo pipefail

SCRIPTDIR="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

source $SCRIPTDIR/config.sh

if [ ! -d $WEB3SIGNER_HOME ]
then
    echo "Set $WEB3SIGNER_HOME to the Web3Signer installation directory in config.sh ..."
    exit 1
fi

export JAVA_OPTS="-Dlog4j.configurationFile=$SCRIPTDIR/web3signer/log4j2-w3s.xml"
export WEB3SIGNER_OPTS=-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=*:5006

$WEB3SIGNER_HOME/bin/web3signer --config-file web3signer/config.yaml eth2
