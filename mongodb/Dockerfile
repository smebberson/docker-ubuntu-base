# DOCKER-VERSION 1.0.0

FROM smebberson/ubuntu-base
MAINTAINER Scott Mebberson <scott@scottmebberson.com>

# Setup MongoDB from binaries
RUN curl -sS http://downloads.mongodb.org/linux/mongodb-linux-x86_64-3.0.1.tgz \
    | tar xz --no-same-owner -C /usr/local --strip-components 1 --wildcards -f - \*/bin/\* && \
    groupadd -r mongodb && \
    useradd -r -g mongodb mongodb && \
    mkdir -p /data/db && \
    chown -R mongodb:mongodb /data/db

# Add the files
ADD root /

# Expose the volume to the host
VOLUME /data/db

# Expose the ports for MongoDB
EXPOSE 27017
