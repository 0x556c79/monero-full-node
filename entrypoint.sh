#!/bin/bash
if [ ! -f /opt/monero/data/bitmonero.conf ]; then
  cp /opt/monero/bitmonero.conf /opt/monero/bitmonero.conf
fi
exec monerod --non-interactive --config-file=/opt/monero/.bitmonero/bitmonero.conf
