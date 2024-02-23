# Besu and Teku Interop mode

## Build Besu/Teku docker image (if required)
- Checkout [Teku](https://github.com/ConsenSys/teku) and/or [Besu](https://github.com/hyperledger/besu).
- In the distribution, run:
```shell
./gradlew distDocker
```
- This should generate local images similar to:
```shell
docker images
```

```Output
docker images
REPOSITORY                 TAG                                IMAGE ID       CREATED              SIZE
hyperledger/besu-evmtool   24.2.0-SNAPSHOT                    016eb6164d13   6 seconds ago        632MB
hyperledger/besu           24.2.0-SNAPSHOT-openjdk-latest     015364bc0249   50 seconds ago       549MB
hyperledger/besu           24.2.0-SNAPSHOT-graalvm            0a58444f9cf5   About a minute ago   1.32GB
hyperledger/besu           24.2.0-SNAPSHOT-openj9-jdk-17      3ceb3b96fe01   About a minute ago   447MB
hyperledger/besu           24.2.0-SNAPSHOT-openjdk-17-debug   da1492384ac3   2 minutes ago        717MB
consensys/teku             develop-jdk21                      dd28b61ae173   2 minutes ago        417MB
hyperledger/besu           24.2.0-SNAPSHOT                    99f2d5d35425   3 minutes ago        635MB
hyperledger/besu           24.2.0-SNAPSHOT-openjdk-17         99f2d5d35425   3 minutes ago        635MB
hyperledger/besu           benchmark                          99f2d5d35425   3 minutes ago        635MB
consensys/teku             develop                            4b7e3ce1735b   3 minutes ago        405MB
consensys/teku             develop-jdk17                      4b7e3ce1735b   3 minutes ago        405MB
```

Update `.env` file with the image tag (if required. Use `latest` to pull from docker.io). For example:
```shell
BESU_TAG=24.2.0-SNAPSHOT
TEKU_TAG=develop-jdk21
```


## Docker Compose commands

| **Command**                                                           | **Description**                               |
|-----------------------------------------------------------------------|-----------------------------------------------|
| `docker compose up`                                                   | Start Besu and Teku                           |
| `docker compose up -d`                                                | Start in detached mode                        |
| `docker-compose -f docker-compose.yml -f docker-compose.debug.yml up` | Start with debugging enabled (port 5007 5008) | 
| `docker compose stop`                                                 | Stop services. Do not delete any volumes.     |
| `docker compose down --rmi all -v`                                    | Stop services. Remove all volumes and images. |
| `docker compose pull`                                                 |                                               |

## Inspect docker volumes

All data is stored in docker volumes. To inspect the data, use the following commands:
```shell
docker volume ls
docker run --rm -it -v interop_besu-data:/data alpine ls -alh /data
```