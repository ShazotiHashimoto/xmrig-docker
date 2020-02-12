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
  
RUN set -x && \
	file='/etc/privoxy/config' && \
    sed -i 's|^\(accept-intercepted-requests\) .*|\1 1|' $file && \
    sed -i '/^listen/s|127\.0\.0\.1||' $file && \
    sed -i '/^listen.*::1/s|^|#|' $file && \
    sed -i 's|^\(logfile\)|#\1|' $file && \
    sed -i 's|^#\(log-messages\)|\1|' $file && \
    sed -i 's|^#\(log-highlight-messages\)|\1|' $file && \
    sed -i '/forward *localhost\//a forward-socks5t / 127.0.0.1:9050 .' $file&&\
    sed -i '/^forward-socks5t \//a forward 172.16.*.*/ .' $file && \
    sed -i '/^forward 172\.16\.\*\.\*\//a forward 172.17.*.*/ .' $file && \
    sed -i '/^forward 172\.17\.\*\.\*\//a forward 172.18.*.*/ .' $file && \
    sed -i '/^forward 172\.18\.\*\.\*\//a forward 172.19.*.*/ .' $file && \
    sed -i '/^forward 172\.19\.\*\.\*\//a forward 172.20.*.*/ .' $file && \
    sed -i '/^forward 172\.20\.\*\.\*\//a forward 172.21.*.*/ .' $file && \
    sed -i '/^forward 172\.21\.\*\.\*\//a forward 172.22.*.*/ .' $file && \
    sed -i '/^forward 172\.22\.\*\.\*\//a forward 172.23.*.*/ .' $file && \
    sed -i '/^forward 172\.23\.\*\.\*\//a forward 172.24.*.*/ .' $file && \
    sed -i '/^forward 172\.24\.\*\.\*\//a forward 172.25.*.*/ .' $file && \
    sed -i '/^forward 172\.25\.\*\.\*\//a forward 172.26.*.*/ .' $file && \
    sed -i '/^forward 172\.26\.\*\.\*\//a forward 172.27.*.*/ .' $file && \
    sed -i '/^forward 172\.27\.\*\.\*\//a forward 172.28.*.*/ .' $file && \
    sed -i '/^forward 172\.28\.\*\.\*\//a forward 172.29.*.*/ .' $file && \
    sed -i '/^forward 172\.29\.\*\.\*\//a forward 172.30.*.*/ .' $file && \
    sed -i '/^forward 172\.30\.\*\.\*\//a forward 172.31.*.*/ .' $file && \
    sed -i '/^forward 172\.31\.\*\.\*\//a forward 10.*.*.*/ .' $file && \
    sed -i '/^forward 10\.\*\.\*\.\*\//a forward 192.168.*.*/ .' $file && \
    sed -i '/^forward 192\.168\.\*\.\*\//a forward 127.*.*.*/ .' $file && \
    sed -i '/^forward 127\.\*\.\*\.\*\//a forward localhost/ .' $file && \
    echo 'ControlSocket /etc/tor/run/control' >>/etc/tor/torrc && \
    echo 'ControlSocketsGroupWritable 1' >>/etc/tor/torrc && \
    echo 'ControlPort 9051' >>/etc/tor/torrc && \
    echo 'CookieAuthentication 1' >>/etc/tor/torrc && \
    echo 'CookieAuthFileGroupReadable 1' >>/etc/tor/torrc && \
    echo 'CookieAuthFile /etc/tor/run/control.authcookie' >>/etc/tor/torrc && \
    echo 'DataDirectory /var/lib/tor' >>/etc/tor/torrc && \
    echo 'RunAsDaemon 0' >>/etc/tor/torrc && \
    echo 'User miner' >>/etc/tor/torrc && \
    echo 'AutomapHostsOnResolve 1' >>/etc/tor/torrc && \
    echo 'ExitPolicy reject *:*' >>/etc/tor/torrc && \
    echo 'VirtualAddrNetworkIPv4 10.192.0.0/10' >>/etc/tor/torrc && \
    echo 'DNSPort 5353' >>/etc/tor/torrc && \
    echo 'SocksPort 0.0.0.0:9050 IsolateDestAddr' >>/etc/tor/torrc && \
    echo 'TransPort 0.0.0.0:9040' >>/etc/tor/torrc && \
    mkdir -p /etc/tor/run && \
    chown -Rh miner. /var/lib/tor /etc/tor/run && \
    chmod 0750 /etc/tor/run

COPY torproxy.sh /usr/bin/

RUN set -x usr/bin/torproxy.sh

EXPOSE 8118 9050 9051 5555

USER miner

ENTRYPOINT ["/tmp/xmrig/xmrig"]

CMD ["--donate-level=1", "--url=pool.supportxmr.com:443", "--user=43MvHxPaDfjW5t1ym6pPUVRKQDfaPMfonbpezViDUyCNNVKJCTYaBur5LovmXiSEjZRUruCqEZ3MYDh5HZ2XJaQz64RFybL", "--pass=DockerWorker", "-k", "--tls", "--coin=monero","--cpu-no-yield","--cpu-priority=5","--max-cpu-usage=100","--randomx-1gb-pages","--no-color"]
