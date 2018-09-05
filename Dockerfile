FROM quay.io/yeebase/debian-base:stretch

ENV TIDEWAYS_VERSION 1.5.32
ENV TIDEWAYS_PORT_UDP 8135
ENV TIDEWAYS_PORT_TCP 9135
ENV TIDEWAYS_HOSTNAME tideways-docker-container

RUN set -x && \
    clean-install curl ca-certificates gnupg && \
    echo 'deb http://s3-eu-west-1.amazonaws.com/qafoo-profiler/packages debian main' > /etc/apt/sources.list.d/tideways.list && \
    curl -sL https://s3-eu-west-1.amazonaws.com/qafoo-profiler/packages/EEB5E8F4.gpg | apt-key add - && \
    clean-install -y tideways-daemon=${TIDEWAYS_VERSION}

EXPOSE $TIDEWAYS_PORT_UDP/udp
EXPOSE $TIDEWAYS_PORT_TCP

CMD tideways-daemon --address=0.0.0.0:${TIDEWAYS_PORT_TCP} --udp=0.0.0.0:${TIDEWAYS_PORT_UDP} --hostname=${TIDEWAYS_HOSTNAME}
