# docker-metabase-relayd
Docker container for metabase-relayd application.

metabase-relayd is a Perl application to act as a relay between CPAN Smoker
machines and the CPAN metabase server.

metabase-relayd is pretty fast (thanks to [POE](http://poe.perl.org/)),
reliable (persists the reports to disk before submission to the metabase
server) and releases CPAN Smokers to continue running tests instead of waiting
a response from the metabase server.  

This project is about using a Docker container to make it easier to install and
run your own metabase-relayd with very little configuration. It uses a
non-root, privilege reduced user with
[local::lib](http://search.cpan.org/~haarg/local-lib-2.000024/lib/local/lib.pm)
and the standard "slim" (no ithread enabled) `perl` provided by the
[official Perl Docker images](https://hub.docker.com/_/perl). In the case you
didn't know, Perl is known to
[run faster](https://www.perlmonks.org/?node_id=868687) with ithreads support.

metabase-relayd details can be found
[here](https://metacpan.org/pod/distribution/metabase-relayd/bin/metabase-relayd).

More details about the CPAN testers project can be found at
http://wiki.cpantesters.org/.

All files on this project are released under GNU GPL version 3.

## Why metabase-relayd on Docker?

Because installing it manually is time consuming: lot's of dependencies (that
are generally not included as prebuilt packages on Linux), which have to be
downloaded, compiled, tested and installed.

Also, most probably the Docker image will have Perl modules with newer versions
compared to those available as packages (well, at least if you can grab decent
recent images).

## How it is done

The Dockerfile for this project uses [multi-stage builds](https://docs.docker.com/develop/develop-images/multistage-build/) in
order to configure [locallib](https://metacpan.org/pod/local::lib), install
`metabase-relayd` with all it's requirements and then move everything to
another Docker image that doesn't have any requirements of whatever is required
to install Perl modules (C compiler, make, etc), making the `metabase-relayd`
image smaller:

```
$ docker images
REPOSITORY                  TAG                 IMAGE ID            CREATED             SIZE
metabase-relayd             0.2                 aabb370cc42f        2 minutes ago       282MB
<none>                      <none>              0c37aafbd98e        3 minutes ago       383MB
```

The `metabase-relayd` will read it's configurations from a mounted volume,
which will allow you to persists the database on whatever location you prefer.

By default, time zone is configured to UTC.

## How to use it

First you will need to configure `metabase-relayd`. Please refer to it's
documentation about how to do it. The `docker-compose.yml` file expects that
you will leave the configuration directory at `$HOME/.metabase` directory.

The easiest way is to `docker pull` the image from the
[Docker hub](https://hub.docker.com/r/alceu/metabase-relayd). You probably
won't need to do anything else but change the timezone (you can change that on
top of the image using a Dockerfile and `FROM alceu/metabase-relayd`).

If you want to build it yourself (one good reason for that is to change the
timezone, see the `TZ` declaration in the `docker-compose.yml` file) will need
to `git clone` this repository and build the image yourself.

After that, copy to the subdirectory metabase your `metabase_id.json` file. The
metabase directory is mounted automatically by the `docker-compose.yml` file
so you can edit the `metabase-relayd` configuration without having to change
anything on the container or image.

Although not required, you can edit the `relayd` configuration file to match
your needs. Refer to the `metabase-relayd` documentation for details. But,
due the [known issues](#know-issues), you probably will be better by using
this configuration sample:

```
address=0.0.0.0
port=8080
idfile=/home/runner/.metabase/metabase_id.json
dbfile=/home/runner/.metabase/relay.db
url=http://metabase.cpantesters.org/api/v1/
debug=1
multiple=1
```

Type `docker-compose up` in a shell and you're ready to go!

## Known issues

At this moment (2022-02-17), metabase-relayd project is not in good shape.

One of it's Perl modules dependencies is
[POE::Component::SSLify](https://metacpan.org/pod/POE::Component::SSLify), which
is not being updated for a long time and it is broken regarding newer versions
of OpenSSL.

That said, metabase-relayd will not support TLS when connecting to
metabase.cpantesters.org, so be sure to configure the `url` configuration
parameter to use `http` instead of `https`.

This is not the ideal, but it will work. Although the data transferred is
basically public, the issue lies in not being sure you are transferring test
reports data to the right place.

## References

- [metabase-relayd](https://metacpan.org/pod/distribution/metabase-relayd/bin/metabase-relayd)
- [Blog post about it](blogs.perl.org/users/bingos/2010/07/cpan-testers-20-and-the-metabase-relayd.html)
