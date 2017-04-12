#!/bin/bash

API_REDIS_EXISTS=$(docker ps -aqf "name=api-redis" | wc -l | awk '{print $1}')
if [[ "$API_REDIS_EXISTS" == "0" ]]; then
        docker run \
                --name api-redis \
                --restart=always \
                -d redis
fi

IS_REDIS_RUNNING=$(docker inspect -f {{.State.Running}} api-redis)
if [[ "$IS_REDIS_RUNNING" != "true" ]]; then
        docker start api-redis
fi
