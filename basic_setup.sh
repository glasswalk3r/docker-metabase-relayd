#!/bin/bash

# This scripts setups whatever can used by both Docker stages

apt-get update
apt-get upgrade -y
ln -snf /usr/share/zoneinfo/$TZ /etc/localtime
echo $TZ > /etc/timezone
apt-get autoremove -y
# cannot install all available modules that includes XS code because they were
# compiled against a perl with ithreads, which won't be available here
apt-get install -y --no-install-recommends bzip2 libssl1.1 openssl \
  libpoe-perl libmro-compat-perl tree libcapture-tiny-perl \
  libyaml-0-2 libyaml-libyaml-perl liblog-log4perl-perl \
  libpoe-component-resolver-perl libpoe-component-client-keepalive-perl \
  libjson-maybexs-perl libmodule-pluggable-perl libjson-perl
apt-get clean -y
addgroup metabase
adduser --ingroup metabase --home /home/runner --shell /bin/bash \
  --disabled-password --gecos '' runner
