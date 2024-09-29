#!/bin/bash
if [ ! -f /opt/monero/.bitmonero/bitmonero.conf ]; then
  cp /opt/monero/bitmonero.conf /opt/monero/.bitmonero/bitmonero.conf
fi
exec ./monerod --non-interactive --config-file=/opt/monero/.bitmonero/bitmonero.conf
