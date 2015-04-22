Consul
======

An image for using [consul][Consul] within Docker containers.

**_Yet another container for running Consul?_**

Yes, as this one is built from my [Ubuntu-based Docker image](https://registry.hub.docker.com/u/smebberson/ubuntu-base/) that contains [s6][s6] for process management.

_**Aren't you only supposed to run one process per container?**_

Well yes and no... the following are good examples of when multiple processes within one container might be necessary:

- automatically updating [nginx][nginx] proxy settings when a down-stream application server (nodejs, php, etc) restarts (and the IP changes)
- automatically updating [HAProxy][haproxy] configuration to load balance to a group of down-stream application servers
- running a logging daemon to centralize log management (i.e. [logentries][logentries], [loggly][loggly], [logstash][logstash])
- when you need to run a script on application server crash (to tidy something up), as the standard [Docker container restart policies][drsp] won't provide this

Usage
-----

To use this image include `FROM smebberson/consul` at the top of your `Dockerfile`, or simply `docker run --name consul smebberson/consul`.

By default, Consul has been configured with:

```
{
    "bootstrap_expect": 1,
    "server": true,
    "node_name": "agent-bootstrapped",
    "data_dir": "/data"
}
```

This setup serves the purpose of a single Consul agent running on a host, mainly for testing. This isn't the recommended scenario, with 3 to 5 total servers per data centre being preferred. However, you can easily customise this by providing your own `config.json` file as discussed below.

Although easily customisable, this image has been designed to run Consul in server mode (without the web ui). If you'd like an image with Consul's web ui, refer to [smebberson/consul-ui][consului]. If you'd like an image purpose-built to be run as an [Consul agent][consulagent].

Customisation
-------------

This container comes setup as follows:

- s6 will automatically start Consul for you
- if Consul dies, it will automatically be restarted

All configuration has been defined in the `root/etc/consul.d/bootstrap/config.json` file (relative to this directory).

To customise configuration for `consul`, replace the file at `root/etc/consul.d/bootstrap/config.json` with your own configuration.

To customise the start script for `consul`, replace the file at `root/etc/s6/consul/run` with your own start script.

[s6]: http://www.skarnet.org/software/s6/
[s6-built-statically]: https://github.com/smebberson/docker-ubuntu-base/blob/master/s6/s6-build
[logentries]: https://logentries.com/
[loggly]: https://www.loggly.com/
[logstash]: http://logstash.net/
[drsp]: https://docs.docker.com/reference/commandline/cli/#restart-policies
[nginx]: http://nginx.org/
[haproxy]: http://www.haproxy.org/
[consul]: https://www.consul.io/
[consului]: https://github.com/smebberson/docker-ubuntu-base/tree/master/consul-ui
[consulagent]: https://github.com/smebberson/docker-ubuntu-base/tree/master/consul-agent
