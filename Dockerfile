# TODO add ARG for base image ver
FROM alpine:3.17.0

ENV GIT_UID 1000

RUN apk update \
 && apk --no-cache upgrade \
 && apk --no-cache add \
      git \
      openssh

WORKDIR /git

RUN adduser -S -u "$GIT_UID" -s /usr/bin/git-shell git \
 && echo git:$RANDOM | chpasswd \
 && mkdir -m 0755 /etc/ssh/keys \
 && echo '' > /etc/motd

COPY git-shell-commands /home/git/git-shell-commands
COPY sshd_config /etc/ssh/sshd_config
COPY get_user_keys /usr/sbin/get_user_keys
COPY docker-entrypoint.sh /docker-entrypoint.sh

EXPOSE 22
VOLUME ["/git", "/etc/ssh/keys"]
ENTRYPOINT ["/docker-entrypoint.sh"]

# TODO add labels
