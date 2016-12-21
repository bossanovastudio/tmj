#!/bin/bash
source /etc/tmj/deploy-vars

echo "Updating NGiNX settings..."
TARGET=$(mktemp)
for i in $(seq 1 $TMJ_INST_COUNT); do
    echo "server 127.0.0.1:300$i;" >> $TARGET
done

CURR_NG_HASH=$(md5sum /etc/nginx/snippets/servers.conf)
NEXT_NG_HASH=$(md5sum $TARGET)
if [[ "$CURR_NG_HASH" != "$NEXT_NG_HASH" ]]; then
    mv $TARGET /etc/nginx/snippets/servers.conf
    service nginx restart
fi
