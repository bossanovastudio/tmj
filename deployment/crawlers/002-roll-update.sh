#!/bin/bash
source /etc/tmj/deploy-vars
IMGNAME="d3estudio/tmj-crawlers:$TMJ_ENV"

function update_instance {
    INST_NAME="$1"
    docker ps -a | grep $INST_NAME 2>&1 > /dev/null
    if [[ "$?" == "0" ]]; then
        docker stop $INST_NAME
        docker wait $INST_NAME
        docker rm $INST_NAME
    fi
    docker run \
        --env-file /etc/tmj/env-vars \
        --restart=always \
        --detach=true \
        --name=$INST_NAME \
        --link crawler-postgres:postgres \
        $IMGNAME \
        $2

}

update_instance "tmj_parser"  "/app/bin/exec_parser"
update_instance "tmj_crawler" "/app/bin/exec_crawler"
