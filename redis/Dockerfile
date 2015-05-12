# DOCKER-VERSION 1.0.0

FROM smebberson/ubuntu-base
MAINTAINER Scott Mebberson <scott@scottmebberson.com>

ENV REDIS_VERSION 3.0.0

# Install redis
RUN \
  cd /tmp && \
  curl -LOk http://download.redis.io/releases/redis-${REDIS_VERSION}.tar.gz && \
  tar xvzf redis-${REDIS_VERSION}.tar.gz && \
  cd redis-${REDIS_VERSION} && \
  make && \
  make install && \
  cp -f src/redis-sentinel /usr/local/bin && \
  mkdir -p /etc/redis && \
  cp -f *.conf /etc/redis && \
  rm -rf /tmp/redis-${REDIS_VERSION}* && \
  echo "include /etc/redis/local.conf" >> /etc/redis/redis.conf && \
  groupadd -r redis && \
  useradd -r -g redis redis && \
  mkdir -p /data && \
  chown -R redis:redis /data

# Define mountable directories.
VOLUME ["/data"]

# Add the files
ADD root /

# Expose ports.
EXPOSE 6379
