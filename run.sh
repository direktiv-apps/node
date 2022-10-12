#!/bin/sh

docker build -t node . && docker run -p 9191:8080 node