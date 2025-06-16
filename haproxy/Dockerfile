FROM haproxy:2.8

USER root

RUN apt-get update \
 && apt-get install -y --no-install-recommends curl \
 && rm -rf /var/lib/apt/lists/*

USER haproxy

ENV MIGRATION_VERSION=100
ENV SEED_COUNT=100
ENV APP_ENV=dev

ENV DB_HOST=postgresdb
ENV DB_PORT=5432
ENV DB_USER=kvisidisi
ENV DB_PASSWORD=root
ENV DB_NAME=kvisidisidb

ENV GF_SECURITY_ADMIN_USER=admin
ENV GF_SECURITY_ADMIN_PASSWORD=admin

ENV GRAFANA_PORT=3000
ENV PROMETHEUS_PORT=9090

ENTRYPOINT ["haproxy", "-f", "/usr/local/etc/haproxy/haproxy.cfg"]
