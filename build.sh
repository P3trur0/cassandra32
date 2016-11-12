#!/bin/bash

VERSION='3.9'
docker build --no-cache=true -t p3trur0/cassandra32 .
docker push p3trur0/cassandra32:latest
docker tag -f p3trur0/cassandra32:latest p3trur0/cassandra32:$VERSION
docker push p3trur0/cassandra32:$VERSION
