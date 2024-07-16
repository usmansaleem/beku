# Web3Signer - Docker Compose commands

## Setup
### Update .env file with the docker image tag
- Update `.env` file with the docker image tag if required. Docker image can either be built locally or it can be used from 
docker hub https://hub.docker.com/r/consensys/web3signer/tags. For example, if the tag is `develop-jdk21` then the file 
should contain:
```.env
WEB3SIGNER_TAG=develop-jdk21
```
### (Optional) Build Web3Signer docker image
- Checkout [web3signer](https://github.com/ConsenSys/web3signer). In the distribution, run:
```shell
./gradlew distDocker
```

This should generate local image similar to:
```shell
docker images
```

```Output
REPOSITORY             TAG             IMAGE ID       CREATED       SIZE
consensys/web3signer   develop-jdk17   66b07327d53e   7 hours ago   356MB
```
Update the `.env` file with the image tag if required.

### Keys Loading
### Default Settings - Bulk Loading
By default, the configuration sets up bulk loading of light interop keys (copied from Teku) for faster startup.

### (Optional) Disable Bulk Loading
Make following changes if you want to load keys by using Key Manager API or LocalStack before starting Web3Signer.

- Comment out by adding a `#` before following lines in `./web3signer-config/config.yaml`
```yaml
# comment out following lines if using import API to upload the keys.
eth2.keystores-path: "/etc/keys"
eth2.keystores-passwords-path: "/etc/passwords"
```
### Option 1: Load using keymanager API
Make sure that bulk-loading is disabled as mentioned above, otherwise, key manager API will not upload the keys as they would be loaded already.

- Key Manager API setting is enabled by default. Once Web3Signer is up, following curl command can be used to either 
upload light keys or full keys. 
```shell
curl -X POST -H "Content-Type: application/json" -d @../interop-keys/interop-keys-light-import.json http://localhost:9005/eth/v1/keystores
```
or
```shell
curl -X POST -H "Content-Type: application/json" -d @../interop-keys/interop-keys-import.json http://localhost:9005/eth/v1/keystores
```
### Option 2: Load using LocalStack (AWS Secrets Manager)
Make sure that bulk-loading is disabled as mentioned above, otherwise keys from localstack won't make any difference.
- Update following option in `./web3signer-config/config.yaml` by changing `false` to `true`
```yaml
eth2.aws-secrets-enabled: false
```

**Proceed with starting web3signer using `docker compose up` command.**

## Docker compose commands:
| **Command**                                                           | **Description**                                     |
|-----------------------------------------------------------------------|-----------------------------------------------------|
| `docker compose up`                                                   | Start Web3Signer (port 9005 ,metrics: 9006)         |
| `docker compose up -d`                                                | Start Web3Signer in detached mode                   |
| `docker-compose -f docker-compose.yml -f docker-compose.debug.yml up` | Start Web3Signer with debugging enabled (port 5006) | 
| `docker compose stop`                                                 | Stop Web3Signer. Do not delete any volumes.         |
| `docker compose down --rmi all -v`                                    | Stop Web3Signer. Remove all volumes and images.     |
| `docker compose pull`                                                 | Pull latest images from Docker Hub                  |


## Testing:

## List Public Keys
```shell
curl http://localhost:9005/api/v1/eth2/publicKeys | jq .
```


