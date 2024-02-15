# Besu and Teku Interop mode

## Build Teku docker image (if required)
Checkout [Teku](https://github.com/ConsenSys/teku). In the distribution, run:
```shell
./gradlew distDocker
```

This should generate local image similar to:
```shell
docker images
```

```Output
REPOSITORY             TAG             IMAGE ID       CREATED          SIZE
consensys/teku         develop-jdk21   f94650fa90e7   8 seconds ago    425MB
consensys/teku         develop         691c3e8efe72   48 seconds ago   413MB
consensys/teku         develop-jdk17   691c3e8efe72   48 seconds ago   413MB
```

Update `beku/interop/.env` file with the image tag if required. For example, if the tag is `develop-jdk21` then the file should contain:
```shell
```shell
TEKU_TAG=develop-jdk21

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