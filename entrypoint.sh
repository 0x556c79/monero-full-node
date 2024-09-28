#!/bin/bash
if [ ! -f /home/monero/.bitmonero/bitmonero.conf ]; then
  cp /home/monero/bitmonero.conf /home/monero/.bitmonero/bitmonero.conf
fi
exec ./monerod --non-interactive --config-file=/home/monero/.bitmonero/bitmonero.conf
