ARG ROOT_IMAGE
FROM $ROOT_IMAGE as builder
USER root
WORKDIR /root
COPY basic_setup.sh /root/
ENV TZ=UTC DEBIAN_FRONTEND=noninteractive
RUN chmod a+x basic_setup.sh && ./basic_setup.sh && rm -f basic_setup.sh
RUN apt-get install -y --no-install-recommends \
  zlib1g-dev libssl-dev curl gcc make wget libmodule-build-perl \
  libmodule-build-tiny-perl libtest-fatal-perl libpoe-test-loops-perl \
  libtest-needs-perl libtest-poe-server-tcp-perl libtest-without-module-perl \
  libtest-requires-perl liburi-fromhash-perl libpath-class-perl \
  libcapture-tiny-perl
WORKDIR /home/runner
USER runner
COPY --chown=runner:runner MyConfig.pm /home/runner/.cpan/CPAN/
COPY --chown=runner:runner install_relayd.sh /home/runner
RUN chmod a+x install_relayd.sh && ./install_relayd.sh

FROM $ROOT_IMAGE
ARG IMAGE_VERSION
LABEL maintainer="glasswalk3r@yahoo.com.br" version="${IMAGE_VERSION}"
LABEL site=https://github.com/glasswalk3r/docker-metabase-relayd name="metabase-relayd"
COPY basic_setup.sh /root/
ENV TZ=UTC DEBIAN_FRONTEND=noninteractive
WORKDIR /root
RUN chmod a+x basic_setup.sh && ./basic_setup.sh && rm -f basic_setup.sh
COPY --chown=runner:runner run_relayd.sh /home/runner/
COPY --chown=runner:runner MyConfig.pm /home/runner/.cpan/CPAN/
COPY --from=builder /home/runner/.bashrc /home/runner/
COPY --from=builder /home/runner/.bash_profile /home/runner/
COPY --from=builder /home/runner/perl5 /home/runner/perl5/
WORKDIR /home/runner
USER runner
CMD ["/bin/bash", "-cl", "/home/runner/run_relayd.sh"]
