FROM influxdb:alpine


RUN apk update && \
    apk add curl && \
    rm -rf /var/cache/apk/*


ENV CONTAINERPILOT_VERSION 2.5.1
ENV CONTAINERPILOT=file:///etc/containerpilot.json
ENV CP_SHA1=b56a9aff365fd9526cd0948325f91a367a3f84a1


# Install Consul Agent
RUN export CONSUL_VERSION=0.7.1 \
    && export CONSUL_CHECKSUM=5dbfc555352bded8a39c7a8bf28b5d7cf47dec493bc0496e21603c84dfe41b4b \
    && curl --retry 7 --fail -vo /tmp/consul.zip "https://releases.hashicorp.com/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_linux_amd64.zip" \
    && echo "${CONSUL_CHECKSUM}  /tmp/consul.zip" | sha256sum -c \
    && unzip /tmp/consul -d /usr/local/bin \
    && rm /tmp/consul.zip \
    && mkdir /config


# Install ContainerPilot
RUN curl -Lso /tmp/containerpilot.tar.gz \
         "https://github.com/joyent/containerpilot/releases/download/${CONTAINERPILOT_VERSION}/containerpilot-${CONTAINERPILOT_VERSION}.tar.gz" \
    && echo "${CP_SHA1}  /tmp/containerpilot.tar.gz" | sha1sum -c \
    && tar zxf /tmp/containerpilot.tar.gz -C /bin \
    && rm /tmp/containerpilot.tar.gz


# COPY ContainerPilot configuration and influx health check
COPY etc/* /etc/
COPY bin/health.sh /usr/local/bin/health.sh


# override the parent entrypoint
ENTRYPOINT ["containerpilot"]
CMD ["influxd"]
