#!/bin/bash

cd
eval "$(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib)"
export PERL5LIB=$PERL5LIB:/usr/share/perl5
exec metabase-relayd
