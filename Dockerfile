FROM debian:stable-slim
ENV TIDEWAYS_VERSION 1.7.26

# RUN set -x && \
#   clean-install curl ca-certificates gnupg && \
#   echo 'deb http://s3-eu-west-1.amazonaws.com/qafoo-profiler/packages debian main' > /etc/apt/sources.list.d/tideways.list && \
#   curl -sL https://s3-eu-west-1.amazonaws.com/qafoo-profiler/packages/EEB5E8F4.gpg | apt-key add - && \
#   clean-install -y tideways-daemon=${TIDEWAYS_VERSION}

RUN useradd --system tideways
RUN apt-get update && apt-get install -yq --no-install-recommends gnupg2 curl sudo ca-certificates

RUN echo 'deb https://packages.tideways.com/apt-packages-main any-version main' > /etc/apt/sources.list.d/tideways.list && \
    curl -L -sS 'https://packages.tideways.com/key.gpg' | apt-key add -
RUN DEBIAN_FRONTEND=noninteractive apt-get update && apt-get install -yq tideways-daemon=${TIDEWAYS_VERSION} && \
    apt-get autoremove --assume-yes && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 9135
EXPOSE 8135/udp

USER tideways

CMD ["tideways-daemon","--hostname=tideways-daemon","--address=0.0.0.0:9135"]

