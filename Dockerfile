ARG ROOT_IMAGE
FROM $ROOT_IMAGE as builder
COPY basic_setup.sh MyConfig.pm /tmp/
ENV TZ=UTC
RUN /tmp/basic_setup.sh && apt-get install -y zlib1g-dev libssl-dev curl gcc \
    make wget libssl-dev
WORKDIR /home/runner
USER runner
COPY install_relayd.sh /home/runner
RUN /home/runner/install_relayd.sh

FROM $ROOT_IMAGE
ARG IMAGE_VERSION
LABEL maintainer="glasswalk3r@yahoo.com.br" version="${IMAGE_VERSION}" name="metabase-relayd"
COPY basic_setup.sh run_relayd.sh MyConfig.pm /tmp/
COPY --from=builder /home/runner/myperl.tar.bz2 /tmp
ENV TZ=UTC
RUN /tmp/basic_setup.sh && rm -f /tmp/basic_setup.sh && chown runner /tmp/myperl.tar.bz2
WORKDIR /home/runner
USER runner
RUN cp /tmp/run_relayd.sh ~/ && \
    chmod 500 ~/run_relayd.sh && tar -C /home/runner -xjf /tmp/myperl.tar.bz2 \
    && rm -f /tmp/myperl.tar.bz2
CMD ["/bin/bash", "-cl", "/home/runner/run_relayd.sh"]
