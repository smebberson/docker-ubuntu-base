# DOCKER-VERSION 1.0.0

FROM smebberson/ubuntu-base
MAINTAINER Scott Mebberson <scott@scottmebberson.com>

# Setup Node.js (Setup NodeSource Official PPA)
# https://github.com/nodesource/docker-node/blob/master/ubuntu/trusty/Dockerfile
RUN curl -sL https://deb.nodesource.com/setup | bash - && \
    apt-get update && \
    apt-get install -y --force-yes apt-transport-https lsb-release python-all git && \
    apt-get install -y --force-yes nodejs && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
