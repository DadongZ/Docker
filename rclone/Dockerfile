FROM alpine:latest

RUN apk add --no-cache curl \
    && apk --no-cache add bash \
    && curl https://rclone.org/install.sh | bash

ENTRYPOINT ["/usr/bin/curl"]
