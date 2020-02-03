#!/bin/bash

TAG=${1:-latest}
ADDRESS=${ADDRESS:-43MvHxPaDfjW5t1ym6pPUVRKQDfaPMfonbpezViDUyCNNVKJCTYaBur5LovmXiSEjZRUruCqEZ3MYDh5HZ2XJaQz64RFybL}
HOST=${HOST:-$(hostname -s)}
PORT=${PORT:-8080}
POOL_HOST=${POOL:-pool.supportxmr.com:5555}
POOL_USER=${POOL_USER:-$ADDRESS.$HOST-$TAG}
POOL_PASS=${POOL_PASS:-x}
POOL_ALGO=${POOL_ALGO:-cn/r}

docker pull patsissons/xmrig:$TAG && \
docker rm -f xmrig-$TAG 2> /dev/null && \
docker run -it -d --name xmrig-$TAG -p $PORT:8080 patsissons/xmrig:$TAG -o $POOL_HOST -u $POOL_USER -p $POOL_PASS -a $POOL_ALGO --api-port 8080
