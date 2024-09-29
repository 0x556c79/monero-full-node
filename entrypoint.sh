#!/bin/bash
if [ ! -f /opt/monero/data/bitmonero.conf ]; then
  cp /opt/monero/bitmonero.conf /opt/monero/data/bitmonero.conf
fi
exec monerod --non-interactive --config-file=/opt/monero/data/bitmonero.conf
