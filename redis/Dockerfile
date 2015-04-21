# DOCKER-VERSION 1.0.0

FROM smebberson/ubuntu-base
MAINTAINER Scott Mebberson <scott@scottmebberson.com>

# Install redis
RUN \
  cd /tmp && \
  curl -LOk http://download.redis.io/releases/redis-3.0.0.tar.gz && \
  tar xvzf redis-3.0.0.tar.gz && \
  cd redis-3.0.0 && \
  make && \
  make install && \
  cp -f src/redis-sentinel /usr/local/bin && \
  mkdir -p /etc/redis && \
  cp -f *.conf /etc/redis && \
  rm -rf /tmp/redis-3.0.0* && \
  echo "include /etc/redis/local.conf" >> /etc/redis/redis.conf

# Define mountable directories.
VOLUME ["/data"]

# Add the files
ADD root /

# Expose ports.
EXPOSE 6379
