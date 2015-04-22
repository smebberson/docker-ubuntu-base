redis
=======

An image for using [redis][redis] within Docker containers.

**_Yet another container for running redis?_**

Yes, as this one is built from my [Ubuntu-based Docker image](https://registry.hub.docker.com/u/smebberson/ubuntu-base/) that contains [s6][s6] for process management.

_**Aren't you only supposed to run one process per container?**_

Well yes and no... the following are good examples of when multiple processes within one container might be necessary:

- automatically updating [nginx][nginx] proxy settings when a down-stream application server (nodejs, php, etc) restarts (and the IP changes)
- automatically updating [HAProxy][haproxy] configuration to load balance to a group of down-stream application servers
- running a logging daemon to centralize log management (i.e. [logentries][logentries], [loggly][loggly], [logstash][logstash])
- when you need to run a script on application server crash (to tidy something up), as the standard [Docker container restart policies][drsp] won't provide this

[s6]: http://www.skarnet.org/software/s6/
[s6-built-statically]: https://github.com/smebberson/docker-ubuntu-base/blob/master/s6/s6-build
[logentries]: https://logentries.com/
[loggly]: https://www.loggly.com/
[logstash]: http://logstash.net/
[drsp]: https://docs.docker.com/reference/commandline/cli/#restart-policies
[nginx]: http://nginx.org/
[haproxy]: http://www.haproxy.org/
[redis]: http://redis.io/

Usage
-----

To use this image include `FROM smebberson/redis` at the top of your `Dockerfile`, or simply `docker run --name redis smebberson/redis`.

### Disable hugepage

By default, you'll probably notice redis output a warning about Transparent Huge Pages when it starts up. The s6 startup script has support to disable this, but you need to run the container in privileged mode:

`docker run --privileged --name redis smebberson/redis`

Customisation
-------------

This container comes setup as follows:

- s6 will automatically start redis for you
- if redis dies, this container will be stopped

To customise the start up process for redis, during your `Dockerfile` build process, copy across a file to `/etc/s6/redis/run`. This file will be used to start `redis`. Within it, start `redis` after performing any setup steps as required.

To customise the redis to auto-restart when `redis` dies, replace `/etc/s6/redis/finish` with a symlink to `/bin/true`.

To customise the redis configuration replace the `/etc/redis/local.conf` in your `Dockerfile`.
