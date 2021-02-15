FROM alpine:latest

MAINTAINER Jim McVea <jmcvea@gmail.com>

LABEL Description="Provides openstack client tools" Version="0.1"

# Alpine-based installation
# #########################
ENV CRYPTOGRAPHY_DONT_BUILD_RUST=1
RUN apk add --update \
  python3-dev \
  curl \
  ca-certificates \
  gcc \
  libffi-dev \
  openssl-dev \
  musl-dev \
  linux-headers \
  && apk add py-setuptools \
  && curl -O https://bootstrap.pypa.io/get-pip.py && python3 get-pip.py \
  && pip install --upgrade --no-cache-dir pip setuptools python-openstackclient python-heatclient \
  && apk del gcc musl-dev linux-headers libffi-dev \
  && rm -rf /var/cache/apk/*

# Add a volume so that a host filesystem can be mounted 
# Ex. `docker run -v $PWD:/data jmcvea/openstack-client`
VOLUME ["/data"]

# Default is to start a shell.  A more common behavior would be to override
# the command when starting.
# Ex. `docker run -ti jmcvea/openstack-client openstack server list`
CMD ["/bin/sh"]

