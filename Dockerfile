# Usage: docker run --restart=always -v /var/data/blockchain-xmr:/home/monero/ -p 18080:18080 -p 18089:18089 --name=monerod -td r4p70r90/monero-full-node
FROM ubuntu:20.04 AS build

ENV MONERO_VERSION=0.17.2.3 MONERO_SHA256=8069012ad5e7b35f79e35e6ca71c2424efc54b61f6f93238b182981ba83f2311
RUN apt-get update && apt-get install -y curl bzip2 wget
WORKDIR /root
RUN wget https://raw.githubusercontent.com/r4p70r90/monero-full-node/master/bitmonero.conf &&\
  curl https://downloads.getmonero.org/cli/monero-linux-x64-v$MONERO_VERSION.tar.bz2 -O &&\
  echo "$MONERO_SHA256  monero-linux-x64-v$MONERO_VERSION.tar.bz2" | sha256sum -c - &&\
  tar -xjvf monero-linux-x64-v$MONERO_VERSION.tar.bz2 &&\
  rm monero-linux-x64-v$MONERO_VERSION.tar.bz2 &&\
  cp ./monero-v$MONERO_VERSION/monerod . &&\  
  rm -r monero-*
  
FROM ubuntu:18.04

RUN useradd -ms /bin/bash monero
USER monero
WORKDIR /home/monero
COPY --chown=monero:monero --from=build /root/monerod /home/monero/monerod
COPY --chown=monero:monero --from=build /root/bitmonero.conf /home/monero/bitmonero.conf
VOLUME /home/monero/
EXPOSE 18080:18080 18089:18089
ENTRYPOINT ["./monerod"]
CMD ["--config-file=/home/monero/bitmonero.conf"]
