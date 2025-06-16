FROM postgres:15

RUN mkdir -p /var/lib/postgresql/data \
 && chown -R postgres:postgres /var/lib/postgresql/data \
 && chmod 700 /var/lib/postgresql/data

RUN apt-get update \
  && apt-get install -y python3-pip curl python3-venv \
  && python3 -m venv /opt/venv \
  && /opt/venv/bin/pip install --upgrade pip \
  && /opt/venv/bin/pip install "patroni[etcd]" psycopg2-binary \
  && rm -rf /var/lib/apt/lists/*

COPY init.sh /usr/local/bin/init.sh
RUN chmod +x /usr/local/bin/init.sh

ENV PATH="/opt/venv/bin:$PATH"

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

USER postgres

ENTRYPOINT ["patroni"]
CMD ["/etc/patroni/config.yml"]
