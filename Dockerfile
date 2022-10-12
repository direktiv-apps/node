FROM golang:1.18.2-alpine as build

WORKDIR /src

COPY build/app/go.mod go.mod
COPY build/app/go.sum go.sum

RUN go mod download

COPY build/app/cmd cmd/
COPY build/app/models models/
COPY build/app/restapi restapi/

ENV CGO_LDFLAGS "-static -w -s"

RUN go build -tags osusergo,netgo -o /application cmd/node-server/main.go; 

FROM ubuntu:22.04

RUN apt-get update && apt-get install ca-certificates -y

RUN apt-get update \
    && apt-get install -y curl \
    && apt-get -y autoclean

RUN mkdir -p /usr/local/nvm
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

ENV NVM_DIR /usr/local/nvm

RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

# !!! updating the latest needs to be updated in swagger.yaml too, default and in the command !!!
ENV NODE_LATEST 18.10.0
ENV NODE_MINUS_1 16.17.1

RUN source $NVM_DIR/nvm.sh \
    && nvm install $NODE_LATEST \
    && nvm alias default  \
    && nvm use default

RUN source $NVM_DIR/nvm.sh \
    && nvm install $NODE_MINUS_1

# DON'T CHANGE BELOW 
COPY --from=build /application /bin/application

EXPOSE 8080

CMD ["/bin/application", "--port=8080", "--host=0.0.0.0", "--write-timeout=0"]