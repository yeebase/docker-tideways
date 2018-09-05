FROM quay.io/yeebase/debian-base:stretch

ENV TIDEWAYS_VERSION 1.5.32

RUN set -x && \
    clean-install curl ca-certificates gnupg && \
    echo 'deb http://s3-eu-west-1.amazonaws.com/qafoo-profiler/packages debian main' > /etc/apt/sources.list.d/tideways.list && \
    curl -sL https://s3-eu-west-1.amazonaws.com/qafoo-profiler/packages/EEB5E8F4.gpg | apt-key add - && \
    clean-install -y tideways-daemon=${TIDEWAYS_VERSION}

EXPOSE 8135/udp
EXPOSE 9135

CMD ["tideways-daemon", "--address=0.0.0.0:9135", "--udp=0.0.0.0:8135"]
