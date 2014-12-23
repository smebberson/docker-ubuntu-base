nginx
=====

An image for using [nginx][nginx] within containers.

**_Yet another container for running nginx?_**

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

Usage
-----

To use this image include `FROM smebberson/nginx` at the top of your `Dockerfile`, or simply `docker run -p 80:80 -p 443:443 -t nginx smebberson/nginx`.

Customisation
-------------

This container comes setup as follows:

- s6 will automatically start nginx for you
- if nginx dies, so will the container
- a basic nginx configuration
- a default HTML file
- nginx logging piped through to the standard [Docker logging][dockerlogs] process

To start nginx using s6:

- create a folder at `/etc/s6/nginx`
- create a file in your new folder called `run` and give it execute permissions
- inside that file start nginx:

### Configuration setup

If you need to, you can run a setup script before starting nginx. During your `Dockerfile` build process, copy across a file to `/etc/s6/nginx/run` with the following (or customise it as required):

```
#!/usr/bin/env bash

if [ -e ./setup ]; then
./setup
fi

# start nginx
exec nginx;
```

### Nginx configuration

A basic nginx configuration is supplied with this image. But it's easy to overwrite:

- create your own `nginx.conf`
- in your `Dockerfile`, make sure your `nginx.conf` file is copied to `/etc/nginx/nginx.conf`

**Make sure you start nginx without daemon mode, by including `daemon off;` in your nginx configuration.**

A default HTML file is also supplied, but again it's easy to overwrite:

- create your own `default.html`
- in your `Dockerfile`, make sure your `default.html` file is copied to `/var/lib/nginx`

_This is assuming you haven't changed the nginx.conf_.

### Restarting nginx

If you're running another process to keep track of something down-stream (for example, automatically updating [nginx][nginx] proxy settings when a down-stream application server (nodejs, php, etc) restarts (and the IP changes)) execute the command `s6-svc -h /etc/s6/nginx` to send a `SIGHUP` to nginx and have it reload its configuration, launch new worker process(es) using this new configuration, while gracefully shutting down the old worker processes.

[s6]: http://www.skarnet.org/software/s6/
[dockerlogs]: https://docs.docker.com/reference/commandline/cli/#logs

### nginx crash

By default, if nginx crashes, the container will stop. This has been configured within `root/etc/s6/nginx/finish`. This is so the host machine can handle any alerts, and automatically restart it.

If you don't want this to happen, simply replace the `root/etc/s6/nginx/finish` with a different file in your image. I like to `ln /bin/true /root/etc/s6/nginx/finish` in those instances.
