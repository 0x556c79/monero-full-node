# Usage: docker run --restart=always -v /var/data/blockchain-xmr:/root/.bitmonero -p 18080:18080 -p 18089:18089 --name=monerod -td r4p70r90/monero-full-node
FROM ubuntu:16.04

ENV MONERO_VERSION=0.13.0.4 MONERO_SHA256=693e1a0210201f65138ace679d1ab1928aca06bb6e679c20d8b4d2d8717e50d6

RUN apt-get update && apt-get install -y curl wget bzip2 libpcsclite-dev

# RUN useradd -ms /bin/bash monero
# USER monero
# WORKDIR /home/monero
WORKDIR /root

RUN curl https://downloads.getmonero.org/cli/monero-linux-x64-v$MONERO_VERSION.tar.bz2 -O &&\
  echo "$MONERO_SHA256  monero-linux-x64-v$MONERO_VERSION.tar.bz2" | sha256sum -c - &&\
  tar -xjvf monero-linux-x64-v$MONERO_VERSION.tar.bz2 &&\
  rm monero-linux-x64-v$MONERO_VERSION.tar.bz2 &&\
  cp ./monero-v$MONERO_VERSION/monerod . &&\
  rm -r monero-* &&\
  wget -P /root/.bitmonero/ https://raw.githubusercontent.com/r4p70r90/monero-full-node/master/bitmonero.conf

# blockchain loaction
VOLUME /root/.bitmonero

EXPOSE 18080:18080 18089:18089

ENTRYPOINT ["./monerod"]
CMD ["--config-file=/root/.bitmonero/bitmonero.conf" "--confirm-external-bind" "--check-updates disabled"]
