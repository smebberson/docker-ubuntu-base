docker-ubuntu-base
==================

A base image for Ubuntu-based Docker images.

This Vagrant vm helps me to manage:

- building [s6](http://www.skarnet.org/software/s6/)
- building the smebberson/ubuntu-base image

Setup
-----

Setup the vagrant machine by running `vagrant up --provider=vmware_fusion`. This will get you a VM running a pretty basic version of Ubuntu with:

- Docker (latest at the time of build)
- installed packages `software-properties-common`,`build-essential`
- a `/build` directory
- a `/packages` directory

Usage
-----

The following describes the various scripts included in this repository to help build s6 and the docker image.

### To build S6
-----------------

There are some scripts to help with this process. Once you're SSH'd into the machine:

- `cd /vagrant`
- to build the [musil](http://www.musl-libc.org/) static compiler, `./s6/musil-build`
- to build the [skalibs](http://www.skarnet.org/software/skalibs/) package, `./s6/skalibs-build`
- to build the [execline](http://www.skarnet.org/software/execline/) package, `./s6/execline-build`
- and finally to build [s6](http://www.skarnet.org/software/s6/), `./s6/s6-build`

There will be a new `.tar.gz` file in `/vagrant/dist/` containing statically compiled s6 binaries.
