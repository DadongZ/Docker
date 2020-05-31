FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive
#noninteractive otherwise will aks geographic region etcs for interactive

RUN apt-get update && apt-get install -y --no-install-recommends build-essential \
	           && apt-get install -y --no-install-recommends apt-utils \
	           && apt-get install -y --no-install-recommends make \
	           && apt-get install -y --no-install-recommends ibz.dev \
	           && apt-get install -y --no-install-recommends m4 \
	           && apt-get install -y --no-install-recommends wget \
                   && apt-get clean


RUN wget --no-check-certificate https://github.com/alexdobin/STAR/archive/2.7.2d.tar.gz \
    && tar xzvf 2.7.2d.tar.gz \
    && cd STAR-2.7.2d/source/ \
    && make STAR

RUN mkdir /data

RUN ln -s /STAR-2.7.2d/source/STAR /usr/bin/STAR

WORKDIR /data

LABEL maintainer="doubleomics@gmail.com"
LABEL VERSION="2.7.2d"


CMD ["STAR"]
