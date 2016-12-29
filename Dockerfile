FROM influxdb:1.1.1-alpine

RUN apk update && \
    apk add curl && \
    rm -rf /var/cache/apk/*


ENV CONTAINERPILOT_VERSION 2.6.0
ENV CONTAINERPILOT=file:///etc/containerpilot.json
ENV CP_SHA1=c1bcd137fadd26ca2998eec192d04c08f62beb1f


# Install ContainerPilot
RUN curl -Lso /tmp/containerpilot.tar.gz \
         "https://github.com/joyent/containerpilot/releases/download/${CONTAINERPILOT_VERSION}/containerpilot-${CONTAINERPILOT_VERSION}.tar.gz" \
    && echo "${CP_SHA1}  /tmp/containerpilot.tar.gz" | sha1sum -c \
    && tar zxf /tmp/containerpilot.tar.gz -C /bin \
    && rm /tmp/containerpilot.tar.gz


# COPY ContainerPilot configuration and influx health check
COPY etc/* /etc/
COPY bin/health.sh /usr/local/bin/health.sh


# Override the parent entrypoint
ENTRYPOINT ["containerpilot"]
CMD ["influxd"]
