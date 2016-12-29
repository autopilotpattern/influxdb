MAKEFLAGS += --warn-undefined-variables
SHELL := /bin/bash
.SHELLFLAGS := -eu -o pipefail
.DEFAULT_GOAL := build

TAG?=latest

# run the Docker build
build:
	docker build -t="autopilotpattern/influxdb:${TAG}" .

# push our image to the public registry
ship:
	docker tag autopilotpattern/influxdb:${TAG} autopilotpattern/influxdb:latest
	docker push "autopilotpattern/influxdb:${TAG}"
	docker push "autopilotpattern/influxdb:latest"
