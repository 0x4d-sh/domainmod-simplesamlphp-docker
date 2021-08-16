#!/bin/bash

git pull
docker rm domainmod_okta
docker rmi $(docker images | grep 'dmod_app')
docker-compose -f ../docker-compose.yml up --build