#!/bin/bash
./001-download-images.sh
UPDATED="$?"
if [[ "$1" != "--force" ]]; then
    if [[ "$UPDATED" == "1" ]]; then
        exit 0
    fi
fi
./002-roll-update.sh
./003-update-nginx-settings.sh
./004-cleanup.sh
