# Usage: docker run -tid --restart=always -v /var/data/xmrchain:/home/monero/.bitmonero -p 18080:18080 -p 18089:18089 --name=monerod -td r4p70r/monero-full-node
FROM ubuntu:22.04 AS build

ENV MONERO_VERSION=0.18.3.4
ENV MONERO_HASH 51ba03928d189c1c11b5379cab17dd9ae8d2230056dc05c872d0f8dba4a87f1d
ENV MONERO_DL_URL https://downloads.getmonero.org/cli/monero-linux-x64-v$MONERO_VERSION.tar.bz2
ENV MONERO_DL_FILE monero-v$MONERO_VERSION.tar.bz2
ENV MONERO_SUMS_FILE sha256sums

WORKDIR /opt/monero

# Update system and install dependencies
# Download Monero binaries from getmonero.org
# Confirm hashes match
# Install daemon binary
# Clean up

RUN apt-get update && apt upgrade -y && apt-get install -y curl bzip2 wget

RUN wget -qO ${MONERO_DL_FILE} ${MONERO_DL_URL} \
  && echo "${MONERO_HASH}  ${MONERO_DL_FILE}" > ${MONERO_SUMS_FILE} \
  && sha256sum -c ${MONERO_SUMS_FILE}; \
  if [ "$?" -eq 0 ]; \
  then \
    echo -e "[+] Hashes match - proceeding with container build"; \
  else \
    echo -e "[!] Hashes do not match - exiting"; \
    exit 5; \
  fi \
  && mkdir ./tmp \
  && tar xjf ${MONERO_DL_FILE} -C ./tmp --strip 1 \
  && mv ./tmp/* /usr/local/bin/ \
  && rm -rf ./tmp ${MONERO_SUMS_FILE} ${MONERO_DL_FILE}
RUN wget https://raw.githubusercontent.com/0x556c79/monero-full-node/master/bitmonero.conf
  
# Copy to fresh Ubuntu image to reduce size
FROM ubuntu:22.04

RUN mkdir -p /opt/monero/data/.bitmonero
COPY --from=build /usr/local/bin/monerod /usr/local/bin/monerod
COPY --from=build /opt/monero/bitmonero.conf /opt/monero/.bitmonero/bitmonero.conf
COPY entrypoint.sh /opt/monero/entrypoint.sh
RUN chmod +x /home/monero/entrypoint.sh

# blockchain location
VOLUME /opt/monero/.bitmonero

EXPOSE 18080
EXPOSE 18081
EXPOSE 18082
EXPOSE 18083

ENTRYPOINT ["/opt/monero/entrypoint.sh"]
