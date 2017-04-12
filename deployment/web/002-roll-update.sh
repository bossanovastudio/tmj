#!/bin/bash
source /etc/tmj/deploy-vars
IMGNAME="d3estudio/tmj-web:$TMJ_ENV"

function update_instance {
    INST_NAME="tmj_web_$1"
    docker ps -a | grep $INST_NAME 2>&1 > /dev/null
    if [[ "$?" == "0" ]]; then
        docker stop $INST_NAME
        docker wait $INST_NAME
        docker rm $INST_NAME
    fi
    docker run \
        --env-file /etc/tmj/env-vars \
        --restart=always \
        --publish="300$i:3000" \
        --detach=true \
        --name=$INST_NAME \
        --link api-redis:redis \
        $IMGNAME
}

echo "Updating $TMJ_INST_COUNT instances..."
for i in $(seq 1 $TMJ_INST_COUNT); do
    update_instance $i
done
