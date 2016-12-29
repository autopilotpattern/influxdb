# Autopilot Pattern InfluxDB

InfluxDB designed for automated operation using the [Autopilot Pattern](http://autopilotpattern.io/). Since the open-source version of InfluxDB doesn't support clustering, this implementation simply registers InfluxDB as a service with Consul and performs local health checks.

[![DockerPulls](https://img.shields.io/docker/pulls/autopilotpattern/influxdb.svg)](https://registry.hub.docker.com/u/autopilotpattern/influxdb/)
[![DockerStars](https://img.shields.io/docker/stars/autopilotpattern/influxdb.svg)](https://registry.hub.docker.com/u/autopilotpattern/influxdb/)

Builds from the latest [alpine image for InfluxDB](https://hub.docker.com/_/influxdb/) with added ContainerPilot support.


## Usage

docker run -e "LOG_LEVEL=debug" -e "CONSUL=https://consulhost" -e "INFLUXDB_ADMIN_ENABLED=true" -p "8083:8083" -p "8086:8086" autopilotpattern/influxdb
