FROM mariadb:10.3

RUN set -x && \
    apt-get update && apt-get install -y --no-install-recommends ca-certificates wget xinetd && \
    rm -rf /var/lib/apt/lists/* && \
    \
    wget -O /usr/local/bin/peer-finder https://storage.googleapis.com/kubernetes-release/pets/peer-finder && \
    chmod +x /usr/local/bin/peer-finder && \
    \
    apt-get purge -y --auto-remove ca-certificates wget

RUN apt-get install -y xinetd
    
ADD ["galera/", "/opt/galera/"]

RUN set -x && \
    cd /opt/galera && chmod +x on-start.sh galera-recovery.sh

ADD ["docker-entrypoint.sh", "/usr/local/bin/"]
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["mysqld"]
