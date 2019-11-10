#!/bin/bash

apt-get update
apt-get upgrade -y
ln -snf /usr/share/zoneinfo/$TZ /etc/localtime
echo $TZ > /etc/timezone
apt-get install -y bzip2 libssl-dev libssl1.1 openssl
apt-get autoremove -y
apt-get clean -y
addgroup metabase
adduser --ingroup metabase --home /home/runner --shell /bin/bash \
  --disabled-password --gecos '' runner
