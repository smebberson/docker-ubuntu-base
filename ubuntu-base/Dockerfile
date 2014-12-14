# DOCKER-VERSION 1.0.0

FROM ubuntu:14.04
MAINTAINER Scott Mebberson <scott@scottmebberson.com>

RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get update && \
    apt-get install -y build-essential && \
    apt-get install -y software-properties-common && \
    apt-get install -y curl rsync && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

ADD root /

ENTRYPOINT ["/usr/bin/s6-svscan","/etc/s6"]
CMD []
