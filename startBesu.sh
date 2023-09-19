#!/bin/bash
set -euo pipefail

SCRIPTDIR="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

source $SCRIPTDIR/config.sh

if [ ! -d $BESU_HOME ]
then
    echo "Set BESU_HOME to the Besu installation directory in config.sh ..."
    exit 1
fi

#export LOG4J_CONFIGURATION_FILE=./log4j2-besu.xml 

export BESU_OPTS=-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=*:5005

$BESU_HOME/bin/besu --config-file besu/besu-config.toml $@
