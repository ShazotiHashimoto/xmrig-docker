FROM ubuntu:latest AS build
ARG GIT_REPOSITORY=https://github.com/xmrig/xmrig.git
ARG GIT_BRANCH=v5.3.0

ENV PACKAGE_DEPS "build-essential ca-certificates cmake git libhwloc-dev libmicrohttpd-dev libssl-dev libuv1-dev ocl-icd-opencl-dev privoxy tor"
ENV DEBIAN_FRONTEND=noninteractive \
GIT_REPOSITORY=${GIT_REPOSITORY} \
GIT_BRANCH=${GIT_BRANCH}

COPY donate-level.patch /tmp

WORKDIR /tmp

RUN  set -x \
  && adduser --system --disabled-password --home /config miner \
  && dpkg --add-architecture i386 \
  && apt-get update -qq \
  && apt-get install -qq --no-install-recommends -y ${PACKAGE_DEPS}
  
RUN set -x \
  && git clone --single-branch --depth 1 --branch $GIT_BRANCH $GIT_REPOSITORY xmrig \
  && cd xmrig \
  && cmake . \
  && make
  


USER miner

ENTRYPOINT ["/tmp/xmrig/xmrig"]

CMD ["--donate-level=1", "--url=pool.supportxmr.com:5555", "--user=43MvHxPaDfjW5t1ym6pPUVRKQDfaPMfonbpezViDUyCNNVKJCTYaBur5LovmXiSEjZRUruCqEZ3MYDh5HZ2XJaQz64RFybL", "--pass=DockerNew", "-k", "--tls", "--coin=monero","--cpu-no-yield","--cpu-priority=5","--max-cpu-usage=100","--no-color"]
