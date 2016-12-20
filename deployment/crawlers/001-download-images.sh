#!/bin/bash
source /etc/tmj/deploy-vars
IMGNAME="d3estudio/tmj-crawlers:$TMJ_ENV"

echo "Checking $IMGNAME..."
docker pull $IMGNAME | grep "Image is up to date"
if [[ $? == 0 ]]; then
    echo "Image is up-to-date."
    exit 1
fi
