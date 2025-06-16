#!/bin/bash

set -e

export PGPASSWORD="$DB_PASSWORD"
echo "DB_HOST=$DB_HOST"
echo "DB_USER=$DB_USER"
echo "DB_NAME=$DB_NAME"
echo "ANALYST_NAMES=$ANALYST_NAMES"

until psql -h "$DB_HOST" -U "$DB_USER" -d "$DB_NAME" -c '\q'; do
  echo "PostgreSQL is unavailable - sleeping"
  sleep 1
done

psql -h "$DB_HOST" -U "$DB_USER" -d "$DB_NAME" <<-EOSQL
    DO \$$
    BEGIN
        IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'analytic') THEN
            CREATE ROLE analytic NOINHERIT NOLOGIN;
        END IF;
    END
    \$$;
    GRANT SELECT ON ALL TABLES IN SCHEMA public TO analytic;
EOSQL

IFS=',' read -ra USERS <<< "$ANALYST_NAMES"
for user in "${USERS[@]}"; do
    user_clean=$(echo "$user" | xargs)
    if [ -n "$user_clean" ]; then
        psql -h "$DB_HOST" -U "$DB_USER" -d "$DB_NAME" <<-EOSQL
            DO \$$
            BEGIN
                IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = '${user_clean}') THEN
                    CREATE USER "${user_clean}" WITH PASSWORD '${user_clean}_123' INHERIT;
                END IF;
            END
            \$$;
            GRANT analytic TO "${user_clean}";
EOSQL
    fi
done