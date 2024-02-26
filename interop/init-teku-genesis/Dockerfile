FROM python:alpine3.19 AS build-env
COPY . /app
WORKDIR /app

RUN pip install --target=/usr/local/lib/python3.19/site-packages requests

FROM gcr.io/distroless/python3
COPY --from=build-env /app /app
COPY --from=build-env /usr/local/lib/python3.19/site-packages /usr/local/lib/python3.19/site-packages

WORKDIR /app
ENV PYTHONPATH=/usr/local/lib/python3.19/site-packages

CMD ["update_genesis_header.py"]