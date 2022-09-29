FROM alpine:latest

RUN apk update && \
  apk upgrade && \
  apk add --no-cache \
  curl \
  openssh-client \
  lftp \
  rsync \
  && rm -rf /var/cache/apk/ \
  && rm -rf /root/.cache \
  && rm -rf /tmp/* \
  && mkdir /root/.ssh \
  && chmod 700 /root/.ssh \
  && echo -e "Host *\n\tStrictHostKeyChecking no\n\n" >> ~/.ssh/config \
  && echo -e "set ssl:verify-certificate off" >> /etc/lftp.conf

WORKDIR /app