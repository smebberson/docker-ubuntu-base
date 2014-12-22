ubuntu-base
===========

A base image for running just about anything within a container, based on Ubuntu 14.04.

Process management
------------------

This image includes [s6](s6) ([built statically][s6-built-statically]), to make it super simple to start multiple process and manage them correctly.

_**Aren't you only supposed to run one process per container?**_ Well yes and no... the following are good examples of when multiple processes within one container might necessary:

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

To use this image include `FROM smebberson/ubuntu-base` at the top of your `Dockerfile`. Inheriting from `smebberson/ubuntu-base` provides you with the ability to easily start any service using [s6][s6]. s6 will also keep it running for you, restarting it when it crashes.

To start your service using s6:

- create a folder at `/etc/s6/service_name`
- create a file in your new folder called `run` and give it execute permissions
- inside that file start your service, for example:

```
#!/usr/bin/env bash

# start nginx
exec nginx;
```

### Finish scripts

If you want to run a script when your application stops, simply:

- create a file in your `/etc/s6/service_name` folder called `finish` and give it execute permissions

In this file, do whatever you need to, but keep it quick and simple (anything over 3 seconds and s6 will force quit it). Once this script has run, s6 will call `/etc/s6/service_name/run` again to restart your service.

### Crashes, logs, no-restarts?

[s6 has a number of other options][s6-servicedir] that you can use to gain more information about your process and what's happening to them.

[s6-servicedir]: http://www.skarnet.org/software/s6/servicedir.html

Examples
--------

An example of using this image can be found in the [smebberson/nodejs][smebbersonnodejs] [Dockerfile][smebbersonnodejsdockerfile].

[smebbersonnodejs]: https://registry.hub.docker.com/u/smebberson/nodejs/
[smebbersonnodejsdockerfile]: https://github.com/smebberson/docker-ubuntu-base/blob/master/nodejs/Dockerfile
