# docker-opendkim

## Description:

This docker image provide a [OpenDKIM](http://www.opendkim.org/) service based on [Alpine Linux](https://hub.docker.com/_/alpine/)

## Usage:
```
docker run --name bind -d -p 8891:8891 \
-v /opendkim/KeyTable:/etc/opendkim/KeyTable
-v /opendkim/SigninTable:/etc/opendkim/SigningTable
-v /opendkim/TrustedHosts:/etc/opendkim/TrustedHosts
-v /opendkim/keys:/tmp/keys
--restart=always aknaebel/opendkim
```

## Docker-compose:
``` 
version: '2'
services:
    opendkim:
        image: aknaebel/opendkim
        volumes:
            - /opendkim/KeyTable:/etc/opendkim/KeyTable
            - /opendkim/SigningTable:/etc/opendkim/SigningTable
            - /opendkim/TrustedHosts:/etc/opendkim/TrustedHosts
            - /opendkim/keys:/tmp/keys
        container_name: opendkim
        ports:
            - "8891:8891"
        restart: always
```

```
docker-compose up -d
```

## OpenDKIM stuff

### KeyTable

a list of keys available for signing

``` 
mail._domainkey.example.com example.com:mail:/etc/opendkim/keys/example.com/mail.private
```

### SigningTable

a list of domains and accounts allowed to sign

```
*@example.com mail._domainkey.example.com
```

### TrustedHosts

a list of servers to "trust" when signing or verifying

```
127.0.0.1
localhost
*.example.com
```

### keys

contain the public/private key for each domain

## Documentation:

See the [official documentation](http://www.opendkim.org/) to configure your openddkim service
