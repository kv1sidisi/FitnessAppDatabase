#!/bin/sh
set -e


cat <<EOF > /etc/cron.d/db_backup

PATH=/usr/local/bin:/usr/local/bin:/usr/bin:/usr/bin:/bin:/bin

DB_HOST=${DB_HOST}
DB_PORT=${DB_PORT}
DB_USER=${DB_USER}
DB_PASSWORD=${DB_PASSWORD}
DB_NAME=${DB_NAME}
BACKUP_RETENTION_COUNT=${BACKUP_RETENTION_COUNT}
${BACKUP_INTERVAL_CRON} root /opt/backup.sh >> /var/log/db_backup.log 2>&1
EOF

chmod 0644 /etc/cron.d/db_backup
touch /var/log/db_backup.log

exec crond -f
