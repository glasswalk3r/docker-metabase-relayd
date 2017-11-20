FROM alpine:latest
COPY basic_setup.sh run_relayd.sh MyConfig.pm /tmp/
RUN /tmp/basic_setup.sh && rm /tmp/basic_setup.sh
COPY install_relayd.sh /home/runner
USER runner
RUN ["/bin/bash", "-c", "/home/runner/install_relayd.sh"]
CMD ["/bin/bash", "-c", "/home/runner/run_relayd.sh"]
