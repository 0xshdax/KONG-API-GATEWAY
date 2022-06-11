#!/bin/bash
# @author : @shdax (github.com/shdax) 

docker network create kong-net
docker-compose up -d kong-database
sleep 3s
docker-compose up kong-migrations
docker-compose up -d kong
