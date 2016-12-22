#!/bin/bash
docker images -a | grep '<none>' | awk '{ print $1 }' | xargs docker rmi 2>/dev/null
