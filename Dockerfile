# Usage: docker run -tid --restart=always -v /var/data/xmrchain:/home/monero/.bitmonero -p 18080:18080 -p 18089:18089 --name=monerod -td r4p70r/monero-full-node
FROM ubuntu:22.04 AS build

ENV MONERO_VERSION=0.18.3.4 MONERO_SHA256=51ba03928d189c1c11b5379cab17dd9ae8d2230056dc05c872d0f8dba4a87f1d

RUN apt-get update && apt-get install -y curl bzip2 wget

WORKDIR /root

RUN wget https://raw.githubusercontent.com/0x556c79/monero-full-node/master/bitmonero.conf &&\
  curl https://downloads.getmonero.org/cli/monero-linux-x64-v$MONERO_VERSION.tar.bz2 -O &&\
  echo "$MONERO_SHA256  monero-linux-x64-v$MONERO_VERSION.tar.bz2" | sha256sum -c - &&\
  tar -xjvf monero-linux-x64-v$MONERO_VERSION.tar.bz2 &&\
  rm monero-linux-x64-v$MONERO_VERSION.tar.bz2 &&\
  cp ./monero-x86_64-linux-gnu-v$MONERO_VERSION/monerod . &&\  
  rm -r monero-*
  
FROM ubuntu:22.04

RUN useradd -ms /bin/bash monero && mkdir -p /home/monero/.bitmonero && chown -R monero:monero /home/monero/.bitmonero
USER monero
WORKDIR /home/monero

COPY --chown=monero:monero --from=build /root/monerod /home/monero/monerod
COPY --chown=monero:monero --from=build /root/bitmonero.conf /home/monero/bitmonero.conf
COPY --chown=monero:monero --from=build /root/bitmonero.conf /home/monero/.bitmonero/bitmonero.conf
COPY --chown=monero:monero entrypoint.sh /home/monero/entrypoint.sh

# blockchain location
VOLUME /home/monero/.bitmonero

EXPOSE 18080:18080 18081:18081

ENTRYPOINT ["/home/monero/entrypoint.sh"]
