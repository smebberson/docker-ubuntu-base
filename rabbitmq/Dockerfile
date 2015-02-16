# DOCKER-VERSION 1.0.0

FROM smebberson/ubuntu-base
MAINTAINER Scott Mebberson <scott@scottmebberson.com>

# Install RabbitMQ
RUN \
  curl https://www.rabbitmq.com/rabbitmq-signing-key-public.asc | apt-key add - && \
  echo "deb http://www.rabbitmq.com/debian/ testing main" > /etc/apt/sources.list.d/rabbitmq.list && \
  apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y rabbitmq-server && \
  rm -rf /var/lib/apt/lists/* && \
  rabbitmq-plugins enable rabbitmq_management --offline

# Add the files
ADD root /

# Expose ports for AMQP protocol and rabbitmq management plugin respectively
EXPOSE 5672 15672
