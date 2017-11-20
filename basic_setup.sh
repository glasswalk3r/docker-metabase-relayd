#!/bin/sh

# housekeeping
apk update
apk upgrade
# alpine curl and wget aren't fully compatible, so we install them
# the rest are Perl modules we want to take advantage of having already packed
# last three are required to compile modules that use XS
apk add curl bash perl make wget perl-net-ssleay perl-moose perl-io-tty perl-dbi perl-data-guid perl-sub-identify perl-params-validate gcc perl-dev musl-dev
# housekeeping
rm -rf /var/cache/apk/*
# adding user and group to run metabase-relayd
addgroup metabase
adduser -G metabase -h /home/runner -D -s /bin/bash runner
