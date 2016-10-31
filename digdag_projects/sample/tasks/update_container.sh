#!/bin/bash
set -e

if [ ! -d $dir ]; then
    git clone $repo
fi

cd $dir
git pull

docker build -t $image_name .

container_id=`docker ps -aq -f "name=$container_name"`
if [ $container_id ]; then
    docker stop $container_id | xargs docker rm
fi

docker run -e DIGDAG_ENDPOINT=$digdag_endpoint --network host --name $container_name -d $image_name
