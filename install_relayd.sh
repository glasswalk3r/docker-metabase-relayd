#!/bin/bash

cd
mkdir -p ~/.cpan/CPAN
cp /tmp/MyConfig.pm ~/.cpan/CPAN
wget http://search.cpan.org/CPAN/authors/id/H/HA/HAARG/local-lib-2.000024.tar.gz
tar xzvf local-lib-2.000024.tar.gz
cd local-lib-2.000024/
perl Makefile.PL --bootstrap --no-manpages
make test && make install
echo 'eval "$(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib)"' >>~/.bashrc
source ~/.bashrc
curl -LO https://raw.githubusercontent.com/miyagawa/cpanminus/master/cpanm
chmod +x cpanm
./cpanm App::cpanminus
rm -fr ./cpanm
cpanm --notest metabase::relayd Module::Pluggable Devel::OverloadInfo List::Util
rm -rf ~/.cpan/build/* ~/.cpan/sources/modules/* ~/.cpan/sources/authors/id/* ~/.cpan/FTPstats.yml
cp /tmp/run_relayd.sh ~/
chmod 500 ~/run_relayd.sh
