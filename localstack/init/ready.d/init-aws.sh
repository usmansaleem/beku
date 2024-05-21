#! /bin/bash

set -o errexit

PREFIX="${SECRET_PREFIX:?Set prefix via env variable}"
SECRET_VALUE_A=$(cat /etc/localstack/init/ready.d/raw1-150.txt)
SECRET_VALUE_B=$(cat /etc/localstack/init/ready.d/raw151-256.txt)
SECRET_NAME_A="${PREFIX}SECRET_A"
SECRET_NAME_B="${PREFIX}SECRET_B"

echo "Creating $SECRET_NAME_A"
awslocal secretsmanager create-secret --name "$SECRET_NAME_A" \
     --description "Interop Keys Test Secret 1-150" \
     --secret-string "$SECRET_VALUE_A"
echo "Created $SECRET_NAME_A"

echo "Creating $SECRET_NAME_B"
awslocal secretsmanager create-secret --name "$SECRET_NAME_B" \
     --description "Interop Keys Test Secret 151-256" \
     --secret-string "$SECRET_VALUE_B"
echo "Created $SECRET_NAME_B"
