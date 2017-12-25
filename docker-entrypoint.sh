#!/bin/sh
echo
/usr/local/bin/dockerd-entrypoint.sh $DOCKER_OPTS --insecure-registry=$REGISTRY &
exec $@