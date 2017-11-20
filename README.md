# docker-metabase-relayd
Docker container for metabase-relayd application.

metabase-relayd is a Perl application to act as a relay between CPAN Smoker machines and the CPAN metabase server.

metabase-relayd is pretty fast (thanks to POE), reliable and releases CPAN Smokers to continue running tests instead of waiting a response from the metabase server.  

This is about using a Docker container to make it easier to install and run your own metabase-relayd with very like configuration.

metabase-relayd details can be found at https://metacpan.org/pod/distribution/metabase-relayd/bin/metabase-relayd.

All files on this project are released under GNU GPL version 3.
