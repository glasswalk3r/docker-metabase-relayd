# docker-metabase-relayd
Docker container for metabase-relayd application.

metabase-relayd is a Perl application to act as a relay between CPAN Smoker machines and the CPAN metabase server.

metabase-relayd is pretty fast (thanks to [POE](http://poe.perl.org/)), reliable (persists the reports to disk before submission to the metabase server) and releases CPAN Smokers to continue running tests instead of waiting a response from the metabase server.  

This project is about using a Docker container to make it easier to install and run your own metabase-relayd with very little configuration. It uses a non-root, privile reduced user with [local::lib](http://search.cpan.org/~haarg/local-lib-2.000024/lib/local/lib.pm) and the standard perl provided by the [Alpine Linux distribution](https://alpinelinux.org/about/).

metabase-relayd details can be found [here](https://metacpan.org/pod/distribution/metabase-relayd/bin/metabase-relayd).

More details about the CPAN testers project can be found at http://wiki.cpantesters.org/.

All files on this project are released under GNU GPL version 3.

## How to use it

By now, the respective Docker image is not available any repository, so you will need to `git clone` this repository and build the image yourself.

Then copy to the subdirectory metabase your `metabase_id.json` file. The metabase directory is mounted automatically by the `docker-compose.yml` file so you can edit the metabase-relayd configuration without having to change anything on the container or image.

Although not required, you can edit the `relayd` configuration file to match your needs. Refer to the metabase-relayd documentation for details.

Type `docker-compose up` in a shell and you're ready to go!
