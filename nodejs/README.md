nodejs
======

An image for using Node.js within containers.

[It's built from my Ubuntu-based Docker image (with s6)](https://registry.hub.docker.com/u/smebberson/ubuntu-base/).

Usage
-----

To use this image include `FROM smebberson/nodejs` at the top of your `Dockerfile`. Inheriting from `smebberson/ubuntu-base` provides you with the ability to easily start your node.js application using [s6][s6]. s6 will also keep it running for you, restarting it when it crashes.

To start your app using s6:

- create a folder at `/etc/s6/app` (or name it whatever you like, just make sure it lives within `/etc/s6`)
- create a file in your new folder called `run` and give it execute permissions
- inside that file start start your node.js application, for example:

```
#!/usr/bin/env bash

# cd into our directory
cd /app

# start our node.js application
exec node server.js;
```

When you run this container, s6 will automatically start your application and make sure it stays running for you.

You'll also need to make sure you go through the usual process of adding your node.js source, installing your packages with `npm` and exposing the necessary ports for your application.

### Logging

If you're logging to stdout (which `console.log` does) then you'll be able to review your logs using the standard [Docker process][dockerlogs].

### Handling uncaught exceptions

The best way to handle exceptions is to:

- capture them
- log them
- exit the process and let s6 restart your app

This will ensure that your errors aren't going un-noticed, but that your application stays up and in proper functioning order. An example of this is:

```
process.on('uncaughtException', function (e) {

    console.log(e);
    process.exit(1);

});
```

[s6]: http://www.skarnet.org/software/s6/
[dockerlogs]: https://docs.docker.com/reference/commandline/cli/#logs
