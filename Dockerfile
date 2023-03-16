FROM php:8.1-cli-alpine

RUN apk update && apk add --no-cache \
  brotli \
  composer \
  curl \
  lftp \
  mysql-client \
  nano \
  openssh-client \
  rsync \
  zip \
  && rm -rf /var/cache/apk/ \
  && rm -rf /root/.cache \
  && rm -rf /tmp/* \
  && mkdir /root/.ssh \
  && chmod 700 /root/.ssh \
  && echo -e "Host *\n\tStrictHostKeyChecking no\n\n" >> ~/.ssh/config \
  && echo -e "set ssl:verify-certificate off" >> /etc/lftp.conf

WORKDIR /app