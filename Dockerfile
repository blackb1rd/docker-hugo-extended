FROM node:lts-alpine

ENV NEOHUGO_VERSION="0.4.1" \
    MOZJPEG_VERSION="4.0.0"

LABEL description="Docker container for building static sites with the neohugo static site generator with extended."
LABEL maintainer="Prachya Saechua<blackb1rd@blackb1rd.me>"

RUN apk add --no-cache \
      bash \
      libc6-compat \
      libpng-dev \
      libpng-static \
      libstdc++ \
      libwebp \
      libwebp-tools \
      openssh-client \
      exiftool \
      pngquant \
      rsync \
      zlib-dev \
      zlib-static \
    && apk add --update --no-cache --virtual .build-deps \
        autoconf \
        automake \
        binutils-gold \
        build-base \
        cmake \
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
    && curl -L https://github.com/neohugo/neohugo/releases/download/v${NEOHUGO_VERSION}/neohugo_extended_${NEOHUGO_VERSION}_Linux-64bit.tar.gz | tar -xz \
    && mv neohugo /usr/local/bin/neohugo \
    && deluser --remove-home node \
    && addgroup -Sg 1000 neohugo \
    && adduser -Sg neohugo -u 1000 -h /src neohugo \
    && curl -L https://github.com/mozilla/mozjpeg/archive/v${MOZJPEG_VERSION}.tar.gz | tar -xz \
    && cd mozjpeg-${MOZJPEG_VERSION} \
    && cmake -DCMAKE_INSTALL_PREFIX=/opt/mozjpeg -DCMAKE_BUILD_TYPE=Release . \
    && make install && cd .. \
    && rm -rf mozjpeg-${MOZJPEG_VERSION} \
    && apk del .build-deps

WORKDIR /src

EXPOSE 1313
