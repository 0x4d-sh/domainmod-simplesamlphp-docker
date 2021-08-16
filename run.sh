#!/bin/bash

git pull
docker stop domainmod_okta
docker rm domainmod_okta
docker rmi $(docker images | grep 'dmod_app')