FROM docker:18.09.3-dind

### BEGIN SHAMELESS THEIVERY OF openjdk ###
ENV LANG C.UTF-8

# add a simple script that can auto-detect the appropriate JAVA_HOME value
# based on whether the JDK or only the JRE is installed
RUN { \
		echo '#!/bin/sh'; \
		echo 'set -e'; \
		echo; \
		echo 'dirname "$(dirname "$(readlink -f "$(which javac || which java)")")"'; \
	} > /usr/local/bin/docker-java-home \
	&& chmod +x /usr/local/bin/docker-java-home
ENV JAVA_HOME /usr/lib/jvm/java-1.8-openjdk
ENV PATH $PATH:/usr/lib/jvm/java-1.8-openjdk/jre/bin:/usr/lib/jvm/java-1.8-openjdk/bin

RUN set -x \
	&& apk add --no-cache openjdk8 \
	&& [ "$JAVA_HOME" = "$(docker-java-home)" ]
### END SHAMELESS THEIVERY OF openjdk ###

# Set up AWS CLI
ARG CLI_VERSION=1.16.125

RUN apk -v --update add python py-pip less nss && \
    pip install --upgrade awscli==$CLI_VERSION && \
    apk -v --purge del py-pip && \
    rm /var/cache/apk/*

