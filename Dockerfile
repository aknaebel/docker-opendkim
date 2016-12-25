FROM alpine:latest
MAINTAINER Alain Knaebel, <alain.knaebel@aknaebel.fr>

RUN apk upgrade --update \
 && echo "http://dl-cdn.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories \
 && echo "http://dl-cdn.alpinelinux.org/alpine/edge/main" >> /etc/apk/repositories \
 && apk --no-progress --no-cache add opendkim openssl supervisor \
 && rm -rf /var/cache/apk/* \
 && mkdir /etc/supervisor.d/ \
 && echo "*.* -/dev/stdout" >> /etc/syslog.conf

COPY ./opendkim.conf /etc/opendkim/opendkim.conf

COPY ./supervisord.conf /etc/supervisor.d/supervisord.conf
COPY ./docker-entrypoint.sh /docker-entrypoint.sh

VOLUME /etc/opendkim/KeyTable
VOLUME /etc/opendkim/SigningTable
VOLUME /etc/opendkim/TrustedHosts
VOLUME /tmp/keys

EXPOSE 8891

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD /usr/bin/supervisord -c /etc/supervisor.d/supervisord.conf
