# Container image that runs your code
FROM alpine:3.10

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh

RUN apk --update --no-cache add git && apk add bash && apk add --update nodejs npm && apk add --update yarn && apk add --update php7 php7-fpm php7-opcache php7-fileinfo && apk add --update composer

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]
