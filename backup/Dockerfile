FROM postgres:17-alpine

RUN apk add --no-cache bash cronie

COPY backup.sh      /opt/backup.sh
COPY entrypoint.sh  /entrypoint.sh

RUN chmod +x /opt/backup.sh /entrypoint.sh \
 && mkdir -p /backups

ENTRYPOINT ["/entrypoint.sh"]
