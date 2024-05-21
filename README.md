# Web3Signer Besu Teku Interop Integration (docker compose)

## Setup
Create docker network for the services to communicate with each other.
```shell
docker network create beku_w3s_network
```

### Start PostgreSQL
```shell
cd postgresql
docker compose up
```

### (Optional) Start LocalStack
If you want to use [LocalStack](https://www.localstack.cloud/) to simulate AWS secrets manager service, you can start LocalStack.
See [localstack readme doc](./localstack/README.md) for more details.
Make sure to make necessary configuration changes before starting Web3Signer. See [web3signer](./web3signer/README.md) for more details.
```shell
cd localstack
docker compose up
```

### Start Web3Signer
Web3Signer uses bulk load to load interop keys by default and uses `develop-jdk17` docker tag.
See [web3signer](./web3signer/README.md) for more details about how to generate local docker image and
disable bulk load to either use Key Manager API or LocalStack before starting Web3Signer.

```shell
cd web3signer
docker compose up
```

### Start grafana and prometheus monitoring
```shell
cd monitoring
docker compose up
```
- Access Grafana dashboard via http://localhost:3000.
See [monitoring](./monitoring/README.md) for more details on how monitoring is setup.

### Start Besu and Teku
```shell
cd interop
docker compose up
```

See [interop](./interop/README.md) for more details on how to start Teku and Besu.

## Acknowledgements
Based on
https://github.com/siladu/beku-timestamp which is a fork of
https://github.com/rolfyone/playground/tree/main/capella/beku
(which is based on https://github.com/ajsutton/merge-scripts/tree/main/beku)