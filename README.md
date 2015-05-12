docker-ubuntu-base
==================

A base image for Ubuntu-based Docker images, featuring s6 process management.

Setup
-----

Setup the vagrant machine by running `vagrant up --provider=vmware_fusion`. This will get you a VM running a pretty basic version of Ubuntu with:

- Docker (latest at the time of build)
- installed packages `software-properties-common`,`build-essential`

This has everything you need to hack on these images.
