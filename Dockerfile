FROM gradle:5.2.1-jdk8-alpine
USER root
ADD https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub /etc/apk/keys/sgerrand.rsa.pub
RUN apk --no-cache update && \
    apk --no-cache add python py-pip py-setuptools openssh-client && \
    pip --no-cache-dir install awscli && \
    rm -rf /tmp/* && \
    rm -rf /var/cache/apk/*

