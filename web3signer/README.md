## Docker Compose commands

| **Command**                                                           | **Description**                                     |
|-----------------------------------------------------------------------|-----------------------------------------------------|
| `docker compose up`                                                   | Start Web3Signer (port 9005 ,metrics: 9006)         |
| `docker compose up -d`                                                | Start Web3Signer in detached mode                   |
| `docker-compose -f docker-compose.yml -f docker-compose.debug.yml up` | Start Web3Signer with debugging enabled (port 5006) | 
| `docker compose stop`                                                 | Stop Web3Signer. Do not delete any volumes.         |
| `docker compose down --rmi all -v`                                    | Stop Web3Signer. Remove all volumes and images.     |
| `docker compose pull`                                                 | Pull latest images from Docker Hub                  |

## Setup
### Build Web3Signer docker image
Checkout [web3signer](https://github.com/ConsenSys/web3signer). In the distribution, run:
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

Update `.env` file with the image tag if required. For example, if the tag is `develop-jdk17` then the file should contain:

```.env
WEB3SIGNER_TAG=develop-jdk17
```
## Use keymanager API

- Commend out following lines in `config.yaml` file if you want to test import API to upload the keys. This will disable
bulk loading of interop validator keys at start up.
```yaml
# comment out following lines if using import API to upload the keys.
eth2.keystores-path: "/etc/keys"
eth2.keystores-passwords-path: "/etc/passwords"
```
- Once Web3Signer is running. Use following curl command to either upload light keys or full
keys. These are interop keys from Teku.
```shell
curl -X POST -H "Content-Type: application/json" -d @../interop-keys/interop-keys-import.json http://localhost:9005/eth/v1/keystores
```
Or
```shell
curl -X POST -H "Content-Type: application/json" -d @../interop-keys/interop-keys-light-import.json http://localhost:9005/eth/v1/keystores
```


