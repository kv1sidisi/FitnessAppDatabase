#!/bin/bash
psql -v ON_ERROR_STOP=1 --username=postgres <<-EOSQL
    CREATE ROLE replicator WITH REPLICATION LOGIN PASSWORD 'replicator';
    CREATE DATABASE postgresdb;
    GRANT ALL PRIVILEGES ON DATABASE postgresdb TO postgres;
EOSQL
