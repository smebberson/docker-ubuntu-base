nginx & nodejs
==============

An image for using both Nginx and Node.js within the same container. This is a combination of [smebberson/nginx][smebbersonnginx] and [smebberson/nodejs][smebbersonnodejs].

[smebbersonngix]: https://registry.hub.docker.com/u/smebberson/nginx/
[smebbersonnodejs]: https://registry.hub.docker.com/u/smebberson/nodejs/

_**What's the use case for such a container?**_

My scenario:

- nginx serves my static files
- nginx also proxies to my web-application (in another container)
- nodejs listens for changes to the web-application container and reconfigures and restarts nginx

Usage
-----

To use this image include `FROM smebberson/nodejs` at the top of your `Dockerfile`.

From there you can:

- configure nginx as required
- include nodejs application
- write an s6 run script for your nodejs application, for example:

```
#!/usr/bin/env bash

# cd into our directory
cd /app

# start our node.js application
exec node server.js;
```
