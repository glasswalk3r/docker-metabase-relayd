#!/bin/bash
cd /home/runner

mkdir -p ~/.cpan/CPAN
cp /tmp/MyConfig.pm ~/.cpan/CPAN
cpanm --local-lib=~/perl5 local::lib && eval $(perl -I ~/perl5/lib/perl5/ -Mlocal::lib)

echo 'eval "$(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib)"' >> ~/.bashrc
echo 'export PERL5LIB=$PERL5LIB:/usr/share/perl5' >> ~/.bashrc
echo '. /home/runner/.bashrc' > ~/.bash_profile

cpanm --local-lib=~/perl5 --notest POE::Component::SSLify
cpanm --local-lib=~/perl5 --notest POE::Component::Client::HTTP
cpanm --local-lib=~/perl5 metabase::relayd
tar -cjf myperl.tar.bz2 .bashrc .bash_profile .cpan .cpanm/ perl5/
chmod a+r myperl.tar.bz2
