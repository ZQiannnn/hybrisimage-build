#!/usr/bin/env bash
set -e
cd $PLATFORM_HOME
ant clean all production

cd ~ && docker build -t $IMAGE_TAG .
docker login -u $USERNAME -p $PASSWORD  $REGISTRY
docker push $IMAGE_TAG