#!/bin/bash

set -e

cpanm --local-lib=~/perl5 local::lib && eval $(perl -I ~/perl5/lib/perl5/ -Mlocal::lib)
echo 'eval "$(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib)"' >> ~/.bashrc
echo 'export PERL5LIB=$PERL5LIB:/home/runner/perl5/lib/perl5:/usr/share/perl5' >> ~/.bashrc
echo '. /home/runner/.bashrc' > ~/.bash_profile
# both are broken with any decent version of OpenSSL
cpanm --local-lib=~/perl5 --notest --verbose POE::Component::SSLify POE::Component::Client::HTTP
cpanm --local-lib=~/perl5 --notest --verbose POE::Component::Client::HTTP
# not required, but nice to have and a low hanging fruit
cpanm --local-lib=~/perl5 CPAN::SQLite
cpanm --local-lib=~/perl5 metabase::relayd
