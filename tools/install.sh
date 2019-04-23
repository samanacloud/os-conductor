#!/bin/bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

mkdir -p /var/log/os_conductor
mkdir -p /etc/os_conductor
if [ ! -f /etc/os_conductor/os_conductor.conf ]; then
    oslo-config-generator \
        --config-file=$DIR/../etc/os_conductor/os_conductor-config-generator.conf \
        --output-file /etc/os_conductor/os_conductor.conf
fi
cp $DIR/os_conductor.service /lib/systemd/system
cp $DIR/init.d/os_conductor /etc/init.d
systemctl daemon-reload
