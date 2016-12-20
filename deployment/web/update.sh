#!/bin/bash
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

$DIR/001-download-images.sh
UPDATED="$?"
if [[ "$1" != "--force" ]]; then
    if [[ "$UPDATED" == "1" ]]; then
        exit 0
    fi
fi
$DIR/002-roll-update.sh
$DIR/003-update-nginx-settings.sh
$DIR/004-cleanup.sh
