#!/bin/bash

state ~/scenarios/multistage-example/Dockerfile
docker images | grep helloworld
