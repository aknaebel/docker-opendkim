#!/bin/sh


for domain in $(cat /etc/opendkim/TrustedHosts)
do
    if [[ $domain == "localhost" || $domain == "127.0.0.1" ]]; then
        continue
    else
        if [ ! -d "/tmp/keys/${domain:2}" ]; then
            mkdir -p /tmp/keys/${domain:2}
            cd /tmp/keys/${domain:2}
            opendkim-genkey -s mail -d ${domain:2}
           chown opendkim:opendkim mail.private
        fi
    fi
done

cp -R /tmp/keys /etc/opendkim/keys
chown -R  opendkim:opendkim /etc/opendkim/keys
exec "$@"
