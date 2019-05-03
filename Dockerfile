FROM perl:5.28-slim as builder
COPY basic_setup.sh MyConfig.pm /tmp/
RUN /tmp/basic_setup.sh && apt-get install -y zlib1g-dev libssl-dev curl gcc \
    make wget libssl-dev
COPY install_relayd.sh /home/runner
USER runner
RUN ["/bin/bash", "-c", "/home/runner/install_relayd.sh"]

FROM perl:5.28-slim
COPY basic_setup.sh run_relayd.sh MyConfig.pm /tmp/
COPY --from=builder /home/runner/myperl.tar.bz2 /tmp
RUN /tmp/basic_setup.sh && rm -f /tmp/basic_setup.sh && chown runner /tmp/myperl.tar.bz2
USER runner
RUN cp /tmp/run_relayd.sh ~/ && chmod 500 ~/run_relayd.sh \
    && tar -C /home/runner -xjf /tmp/myperl.tar.bz2 \
    && rm -f /tmp/myperl.tar.bz2
CMD ["/bin/bash", "-cl", "/home/runner/run_relayd.sh"]
