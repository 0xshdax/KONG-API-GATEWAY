#!/bin/bash
# @author : @0xshdax (github.com/0xshdax) 

docker network create kong-net
docker-compose up -d kong-database
sleep 3s
docker-compose up kong-migrations
docker-compose up -d kong
