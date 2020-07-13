FROM node:lts-alpine

ENV HUGO_VERSION="0.74.0" \
    MOZJPEG_VERSION="3.3.1"

LABEL description="Docker container for building static sites with the Hugo static site generator with extended."
LABEL maintainer="Prachya Saechua<blackb1rd@blackb1rd.me>"

RUN apk add --no-cache \
      libstdc++ \
      openssh-client \
      rsync \
      bash \
      libc6-compat \
      libpng-dev \
      pngquant \
      zlib-dev \
    && apk add --update --no-cache --virtual .build-deps \
        autoconf \
        automake \
        binutils-gold \
        build-base \
        curl \
        g++ \
        gcc \
        git \
        gnupg \
        gzip \
        libgcc \
        libstdc++ \
        libtool \
        linux-headers \
        make \
        nasm \
        pkgconf \
        python \
        tar \
        xz \
    && mkdir -p /usr/local/src \
    && cd /usr/local/src \
    && curl -L https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_extended_${HUGO_VERSION}_Linux-64bit.tar.gz | tar -xz \
    && mv hugo /usr/local/bin/hugo \
    && deluser --remove-home node \
    && addgroup -Sg 1000 hugo \
    && adduser -Sg hugo -u 1000 -h /src hugo \
    && curl -L https://github.com/mozilla/mozjpeg/archive/v${MOZJPEG_VERSION}.tar.gz | tar -xz \
    && cd mozjpeg-${MOZJPEG_VERSION} \
    && autoreconf -fiv \
    && ./configure --prefix=/opt/mozjpeg \
    && make install && cd .. \
    && rm -rf mozjpeg-${MOZJPEG_VERSION} \
    && apk del .build-deps

WORKDIR /src

EXPOSE 1313
