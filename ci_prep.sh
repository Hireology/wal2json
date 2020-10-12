#!/bin/bash
export PATH=/usr/lib/postgresql/${POSTGRESQL_VERSION}/bin/:$PATH

cd $HOME/src/github.com/Hireology/wal2json
USE_PGXS=1 PG_CONFIG=/usr/lib/postgresql/${POSTGRESQL_VERSION}/bin/pg_config make -e
sudo USE_PGXS=1 PG_CONFIG=/usr/lib/postgresql/${POSTGRESQL_VERSION}/bin/pg_config make -e install

psql -p ${POSTGRESQL_PORT} -c "alter system set wal_level = 'logical'"
psql -p ${POSTGRESQL_PORT} -c "alter system set max_replication_slots = 1"
echo $PGDATA
sudo pg_ctl restart

