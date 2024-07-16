# Web3Signer Besu Teku Interop Integration (docker compose)

## Docker Network (required)
Create docker network for the services to communicate with each other.
```shell
docker network create beku_w3s_network
```

### Start PostgreSQL (required)
PostgreSQL is required to store slashing protection data and is required by Web3Signer.
See [postgresql](./postgresql/README.md) for more details.
```shell
cd postgresql
docker compose up
```

### Start LocalStack - AWS Secrets Manager (optional)
If you want to use [LocalStack](https://www.localstack.cloud/) to simulate AWS secrets manager service, you can start LocalStack.
See [localstack readme doc](./localstack/README.md) for more details.
Make sure to make necessary configuration changes before starting Web3Signer. See [web3signer](./web3signer/README.md) for more details.
```shell
cd localstack
docker compose up
```

### Start Web3Signer (required)
Web3Signer uses bulk load to load interop keys and uses `develop-jdk21` docker tag.
See [web3signer](./web3signer/README.md) for more details about how to disable bulk load to either use Key Manager API 
or LocalStack (AWS simulation) before starting Web3Signer.

```shell
cd web3signer
docker compose up
```

### Start grafana and prometheus monitoring (optional)
- Access Grafana dashboard via http://localhost:3000. 
- See [monitoring](./monitoring/README.md) for more details on how monitoring is setup.
```shell
cd monitoring
docker compose up
```

### Start Besu and Teku (required)
See [interop](./interop/README.md) for more details on how to start Teku and Besu.

```shell
cd interop
docker compose up
```

## Acknowledgements
Based on
https://github.com/siladu/beku-timestamp which is a fork of
https://github.com/rolfyone/playground/tree/main/capella/beku
(which is based on https://github.com/ajsutton/merge-scripts/tree/main/beku)

## License

Licensed under either of

* Apache License, Version 2.0, ([LICENSE-APACHE](LICENSE-APACHE-2.0) or <http://www.apache.org/licenses/LICENSE-2.0>)
* MIT license ([LICENSE-MIT](LICENSE-MIT) or <http://opensource.org/licenses/MIT>)

at your option.
`SPDX-License-Identifier: (Apache-2.0 OR MIT)`

### Contribution

Unless you explicitly state otherwise, any contribution intentionally submitted for inclusion in the work by you, as
defined in the Apache-2.0 license, shall be dual licensed as above, without any additional terms or conditions.