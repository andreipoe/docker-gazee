#!/bin/sh

set -u
set -e

chown -R gazee.gazee /config /comics /mylar /certs

su - gazee -c 'python3 /gazee/Gazee.py -c /config -d'

# Gazee will reload and go to backgroud on a config change, so do this to keep the conainter alive
tail -f /dev/null

