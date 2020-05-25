docker image build -t local.nginx ./udemy-docker-mastery/dockerfile-sample-1/

docker image build -t local.nginx:v0 ./udemy-docker-mastery/dockerfile-sample-1/
#very fast due to using cache/layers

#Sending build context to Docker daemon  4.096kB
#Step 1/7 : FROM debian:stretch-slim
#---> fa41698012c7
#Step 2/7 : ENV NGINX_VERSION 1.13.6-1~stretch
#---> Using cache
#---> 37c54af4afb8
#Step 3/7 : ENV NJS_VERSION   1.13.6.0.1.14-1~stretch
#---> Using cache
#---> d5632a2767bc
#Step 4/7 : RUN apt-get update   && apt-get install --no-install-recommends --no-install-suggests -y gnupg1      &&     NGINX_GPGKEY=573BFD6B3D8FBC641079A6ABABF5BD827BD9BF62;                                                               found='';        for server in           ha.pool.sks-keyservers.net              hkp://keyserver.ubuntu.com:80          hkp://p80.pool.sks-keyservers.net:80
#pgp.mit.edu     ; do            echo "Fetching GPG key $NGINX_GPGKEY from $server";             apt-key adv --keyserver "$server" --keyserver-options timeout=10 --recv-keys "$NGINX_GPGKEY" && found=yes && break;                         done;    test -z "$found" && echo >&2 "error: failed to fetch GPG key $NGINX_GPGKEY" && exit 1;  apt-get remove --purge -y gnupg1 && apt-get -y --purge autoremove && rm -rf /var/lib/apt/lists/*                                            && echo "deb http://nginx.org/packages/mainline/debian/ stretch nginx" >> /etc/apt/sources.list  && apt-get update      && apt-get install --no-install-recommends --no-install-suggests -y
#nginx=${NGINX_VERSION}                                          nginx-module-xslt=${NGINX_VERSION}
#nginx-module-geoip=${NGINX_VERSION}                                             nginx-module-image-filter=${NGINX_VERSION}
#nginx-module-njs=${NJS_VERSION}                                                 gettext-base                                                                                                                && rm -rf /var/lib/apt/lists/*
#---> Using cache
#---> ed1d0a0f86a0
#Step 5/7 : RUN ln -sf /dev/stdout /var/log/nginx/access.log     && ln -sf /dev/stderr /var/log/nginx/error.log
#---> Using cache
#---> 51fe379ba58c
#Step 6/7 : EXPOSE 80 443
#---> Using cache
#---> d3b6c98bc4e3
#Step 7/7 : CMD ["nginx", "-g", "daemon off;"]
#---> Using cache
#---> 8480bb536982
#Successfully built 8480bb536982
#Successfully tagged local.nginx:v0

docker image build -t nginx-with-html:testing ./udemy-docker-mastery/dockerfile-sample-2/
docker container run -d --rm -p 80:80 nginx-with-html:testing #have to add :testing if not latest
docker image tag nginx-with-html:testing ddzhangzz/nginx-with-html:latest 
