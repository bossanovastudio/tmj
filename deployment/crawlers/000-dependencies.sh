#!/bin/bash

CRAWLER_PG_EXISTS=$(docker ps -aqf "name=crawler-postgres" | wc -l | awk '{print $1}')
if [[ "$CRAWLER_PG_EXISTS" == "0" ]]; then
        docker run \
                --name crawler-postgres \
                --restart=always \
        -v /etc/tmj/crawler-data:/var/lib/postgresql/data \
        -p "5432:5432" \
        -e "POSTGRES_USER=tmj_crawlers" \
        -e "POSTGRES_PASS=1em1bilhao" \
                -d postgres
fi

IS_PG_RUNNING=$(docker inspect -f {{.State.Running}} crawler-postgres)
if [[ "$IS_PG_RUNNING" != "true" ]]; then
        docker start crawler-postgres
fi
