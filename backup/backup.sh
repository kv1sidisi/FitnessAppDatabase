#!/bin/sh
set -e

BACKUP_DIR=/backups

TIMESTAMP=$(date +'%Y%m%d%H%M%S')

FILENAME=backup_${TIMESTAMP}.sql

export PGPASSWORD="$DB_PASSWORD"
/usr/local/bin/pg_dump --host="$DB_HOST" --port="$DB_PORT" --username="$DB_USER" --format=plain \
        --dbname="$DB_NAME" > "${BACKUP_DIR}/${FILENAME}"

cd "$BACKUP_DIR"
ls -1t backup_*.sql | tail -n +"$((BACKUP_RETENTION_COUNT + 1))" | xargs -r rm --
