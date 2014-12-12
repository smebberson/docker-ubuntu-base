#!/usr/bin/env bash

# set timezone to Adelaide

if [ ! -e /etc/vagrant/timezone ]
  then

  echo ">>> setting up timezone"

  # set Adelaide as the local timezone
  echo "Australia/Adelaide" | tee /etc/timezone

  dpkg-reconfigure --frontend noninteractive tzdata

  # only run once
  touch /etc/vagrant/timezone

else

  echo ">>> timezone is already setup"

fi
