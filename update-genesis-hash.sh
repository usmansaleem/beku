#!/bin/bash

URL="http://127.0.0.1:8545"
METHOD="eth_getBlockByNumber"
PARAMS='["0x0", true]'

read -r -d '' DATA << EOF
{
  "jsonrpc":"2.0",
  "id":1,
  "method":"$METHOD",
  "params":$PARAMS
}
EOF

END=$((SECONDS+10))
STATUS=0

echo "Checking Besu status ..."
while [ $SECONDS -lt $END ]; do
  HTTP_CODE=$(curl --max-time 10 -s -o /dev/null -w "%{http_code}" -X POST -H "Content-Type: application/json" --data "$DATA" $URL)
  STATUS=$?
  if [ $HTTP_CODE -eq 200 ]; then
    RESPONSE=$(curl -s -H "Content-Type: application/json" --data "$DATA" $URL)
    HASH=$(echo $RESPONSE | jq -r '.result.hash')
    break
  fi
  sleep 2
  echo "Checking Besu status again ..."
done

if [ $STATUS -ne 0 ]; then
  echo "Request failed with status code: $HTTP_CODE. Make sure Besu is running."
  exit 1
fi

echo "Request was successful, genesis hash: $HASH"
echo "Creating genesis-header.json from template ..."
jq --arg hash "$HASH" '.parent_hash = $hash' genesis-header.json.template > genesis-header.json

echo "Teku can be started now!"


