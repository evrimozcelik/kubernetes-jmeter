# inspired by https://github.com/justb4/docker-jmeter

FROM alpine:3.5

ARG JMETER_VERSION="3.3"
ENV JMETER_HOME /opt/apache-jmeter-${JMETER_VERSION}
ENV	JMETER_BIN	${JMETER_HOME}/bin
ENV	JMETER_DOWNLOAD_URL  http://www-us.apache.org/dist//jmeter/binaries/apache-jmeter-${JMETER_VERSION}.tgz

# Install extra packages
# Change TimeZone 
ARG TZ="Europe/Istanbul"
RUN apk update
RUN apk upgrade
RUN apk add ca-certificates && update-ca-certificates
RUN apk add --update openjdk8-jre tzdata curl unzip bash
# Clean APK cache
RUN rm -rf /var/cache/apk/*

# download and extract JMeter
RUN mkdir -p /tmp/dependencies
RUN	curl -L --silent ${JMETER_DOWNLOAD_URL} >  /tmp/dependencies/apache-jmeter-${JMETER_VERSION}.tgz
RUN mkdir -p /opt

RUN tar -xzf /tmp/dependencies/apache-jmeter-${JMETER_VERSION}.tgz -C /opt && \
    rm -rf /tmp/dependencies

# Set global PATH such that "jmeter" command is found
ENV PATH $PATH:$JMETER_BIN

# Entrypoint has same signature as "jmeter" command
COPY entrypoint.sh /

WORKDIR	${JMETER_HOME}

ENTRYPOINT ["/entrypoint.sh"]
