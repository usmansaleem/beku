FROM python:alpine3.19 AS build-env
COPY . /app
WORKDIR /app

FROM gcr.io/distroless/python3
COPY --from=build-env /app /app
COPY --from=build-env --chown=1000:1000 /app/data-marker /besu-data
COPY --from=build-env --chown=1000:1000 /app/data-marker /teku-data
WORKDIR /app
CMD ["modify_json.py"]