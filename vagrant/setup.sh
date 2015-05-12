#!/usr/bin/env bash

if [ ! -e /etc/vagrant/setup ]
then

	echo ">>> setting up this vm"

	# only run once
	touch /etc/vagrant/setup

else

	echo ">>> vm setup has already been completed..."

fi
