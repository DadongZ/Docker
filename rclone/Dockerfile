FROM alpine:latest

RUN apk update  
RUN apk add --no-cache curl bash  

RUN curl -O https://downloads.rclone.org/v1.52.0/rclone-v1.52.0-linux-amd64.zip \
    && unzip rclone-v1.52.0-linux-amd64.zip 

RUN cd rclone-v1.52.0-linux-amd64 \
    && cp rclone /usr/bin/ \
    && chown root:root /usr/bin/rclone \
    && chmod 755 /usr/bin/rclone 

RUN mkdir -p /root/.config/rclone/

VOLUME "/usr/lib/rclone"

CMD ["rclone"]
