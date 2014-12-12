#!/usr/bin/env bash

if [ ! -e /etc/vagrant/setup ]
then

	echo ">>> setting up this vm"

	# Create the packages directory and setup permissions
	mkdir /package
	chown vagrant:vagrant /package

	# Create the build directory and setup permissions
	mkdir /build
	chown vagrant:vagrant /build

	# only run once
	touch /etc/vagrant/setup

else

	echo ">>> vm setup has already been completed..."

fi
