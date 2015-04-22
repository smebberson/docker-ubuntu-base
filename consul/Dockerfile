# DOCKER-VERSION 1.0.0

FROM smebberson/ubuntu-base
MAINTAINER Scott Mebberson <scott@scottmebberson.com>

# Install Unzip
RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get update && \
    apt-get install -y unzip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Download and install Consul
RUN curl -sSLO https://dl.bintray.com/mitchellh/consul/0.5.0_linux_amd64.zip && \
    unzip 0.5.0_linux_amd64.zip && \
    chmod +x consul && \
    mv consul /usr/local/bin/consul && \
    rm 0.5.0_linux_amd64.zip && \
    groupadd -r consul && \
    useradd -r -g consul consul && \
    mkdir -p /data && \
    chown -R consul:consul /data

# Add the files
ADD root /

VOLUME ["/data"]

EXPOSE 8300 8301 8301/udp 8302 8302/udp 8400 53 53/udp
