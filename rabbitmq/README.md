rabbitmq
======

An image for using (RabbitMQ)[https://www.rabbitmq.com/] within containers.

[It's built from my Ubuntu-based Docker image (with s6)](https://registry.hub.docker.com/u/smebberson/ubuntu-base/).

Usage
-----

To use this image include `FROM smebberson/rabbitmq` at the top of your `Dockerfile`. Inheriting from `smebberson/ubuntu-base` provides you with the ability to easily start your rabbitmq server using [s6][s6]. s6 will also keep it running for you, restarting it when it crashes.

When you run this container, s6 will automatically start your RabbitMQ server and make sure it stays running for you.

### Configurations

You can configure the following settings in your Dockerfile:

```
# set username and password for default user login to access RabbitMQ
ENV RABBITMQ_USER={username} RABBITMQ_PASS={password}

# set paths for RabbitMQ data file if you like to persist the data
ENV RABBITMQ_LOG_BASE /data/log
ENV RABBITMQ_MNESIA_BASE /data/mnesia

# Define mount points.
VOLUME ["/data/log", "/data/mnesia"]

# Define working directory.
WORKDIR /data

# Set permission for the /data (The server is set up to run as system user rabbitmq)
RUN chown -R rabbitmq:rabbitmq /data

```

**Please note:** If ```RABBITMQ_USER``` and ```RABBITMQ_PASS``` environment variable is not set, it will use the default RabbitMQ user logins which use ```guest``` as the username and password.

### RabbitMQ Management Plugin

You can access the mangement UI admin via http://server-name:15672. See above for login details.
For more info see (RabbitMQ documentations)[https://www.rabbitmq.com/management.html].

### Run RabbitMQ server

You can start up your RabbitMQ server using the following command:

```
docker run -d -p 5672:5672 -p 15672:15672 smebberson/rabbitmq
```

### Run RabbitMQ server with persistent shared directories

```
docker run -d -p 5672:5672 -p 15672:15672 -v <log-dir>:/data/log -v <data-dir>:/data/mnesia smebberson/rabbitmq


[s6]: http://www.skarnet.org/software/s6/
