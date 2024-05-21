# LocalStack Docker Compose

The docker compose example shows how to use localstack to simulate AWS secrets manager service.
It loads secret manager with interop keys under `test-aws-integration/` prefix.
Web3Signer will use this prefix to load the interop keys from LocalStack (AWS Secrets Manager).

| **Command**                         | **Description**                                 |
|-------------------------------------|-------------------------------------------------|
| `docker compose up`                 | Start localstack (port 4566 )                   |
| `docker compose up -d`              | Start localstack in detached mode               |
| `docker compose stop`               | Stop localstack. Do not delete any volumes.     |
| `docker compose down --rmi all -v`  | Stop localstack. Remove all volumes and images. |
| `docker compose pull`               | Pull latest images from Docker Hub              |


### Test using aws-cli docker image:
```shell
docker run --rm -it --network beku_w3s_network \
-e AWS_ACCESS_KEY_ID=test -e AWS_SECRET_ACCESS_KEY=test -e AWS_REGION=us-east-2 -e AWS_SESSION_TOKEN=test \
amazon/aws-cli --endpoint-url=http://localstack:4566 secretsmanager list-secrets --query 'SecretList[].Name'
```
should give output:
```
[
    "test-aws-integration/SECRET_A",
    "test-aws-integration/SECRET_B"
]
```