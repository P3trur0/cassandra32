#!/bin/bash
ADDR=$(ip addr | grep 'inet ' | grep eth0 | cut -d/ -f1 | awk '{print $2}')
CONF=/etc/cassandra/cassandra.yaml

echo "Cassandra will bind to $ADDR"

sed -i -e "s/^listen_address: .*$/listen_address: $ADDR/g" $CONF
grep "^listen_address" $CONF

sed -i -e "s/^rpc_address: .*$/rpc_address: $ADDR/g" $CONF
grep "^rpc_address" $CONF

sed -i -e "s/- seeds: \".*\"/- seeds: \"$ADDR\"/g" $CONF
grep "\- seeds:" $CONF

cassandra -f
