# Pull base image
FROM resin/rpi-raspbian:jessie
MAINTAINER Max Huang <maxh1981@gmail.com>

# Setup external package-sources
RUN apt-get update \
 && apt-get install -y --no-install-recommends \
        apt-transport-https \
        curl \
 && curl -sL https://repos.influxdata.com/influxdb.key | sudo apt-key add - \
 && echo "deb https://repos.influxdata.com/debian jessie stable" > /etc/apt/sources.list.d/influxdb.list \
 && apt-get update \
 && apt-get install -y --no-install-recommends \
        influxdb \
 && apt-get remove --auto-remove -y \
        apt-transport-https \
        curl \
 && rm -rf \
        /var/lib/apt/lists/*

EXPOSE 8086

CMD influxd
