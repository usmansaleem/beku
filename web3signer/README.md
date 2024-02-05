## Build Web3Signer docker image
In Web3Signer distribution, run:
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

Update `.env` file with the image tag:
```shell
WEB3SIGNER_TAG=develop-jdk17
```

## Docker Compose commands

| **Command**                                                           | **Description**                                     |
|-----------------------------------------------------------------------|-----------------------------------------------------|
| `docker compose up`                                                   | Start Web3Signer                                    |
| `docker compose up -d`                                                | Start Web3Signer in detached mode                   |
| `docker-compose -f docker-compose.yml -f docker-compose.debug.yml up` | Start Web3Signer with debugging enabled (port 5006) | 
| `docker compose stop`                                                 | Stop Web3Signer. Do not delete any volumes.         |
| `docker compose down --rmi all -v`                                    | Stop Web3Signer. Remove all volumes and images.     |
| `docker compose pull`                                                 | Pull latest images locally or from Docker Hub       |
