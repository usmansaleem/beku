# Grafana and Prometheus Monitoring 

- Access Grafana dashboard via [http://localhost:3000](http://localhost:3000).
- See `prometheus/prometheus.yml` for Prometheus configuration.

## Docker Compose commands

| **Command**                        | **Description**                                          |
|------------------------------------|----------------------------------------------------------|
| `docker compose up`                | Start Grafana and Prometheus.                            |
| `docker compose up -d`             | Start in detached mode.                                  |
| `docker compose stop`              | Halts Grafana and Prometheus. Do not delete any volumes. |
| `docker compose down --rmi all -v` | Remove all volumes and images.                           |


