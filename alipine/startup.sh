#!/bin/sh
set -e
if [ -f /opt/binaries/HYBRIS.zip ]; then
    echo "Unzip Binaries"
    unzip /opt/binaries/HYBRIS.zip -d /opt
else
    echo "No Binaries  HYBRIS.zip Found"
    exit
fi

echo "Set Up Hybris"
cd $PLATFORM_HOME
ant clean all production -Dproduction.legacy.mode=false

echo "Wait For Docker"
success=""
while [ x${success} == x ]
do
    docker ps && {
        success="success"
    } || {
        sleep 1
    }
done

echo "Set Up Docker Image"
docker load --input /root/hybris-base-image.tar



echo "Build Image"
mv /opt/hybris/temp/hybris/hybrisServer/hybrisServer*.zip /root
cd /root && docker build -t $IMAGE_TAG .

echo "Push Image"
if [ ! -z "$USERNAME" ] &&  [ ! -z "$PASSWORD" ] &&  [ ! -z "$REGISTRY" ]; then
    docker login  -u $USERNAME -p $PASSWORD $REGISTRY
fi

docker push $IMAGE_TAG