#!/bin/bash

stat ~/scenarios/hello-world/Dockerfile
docker images | grep helloworld | wc -l 
