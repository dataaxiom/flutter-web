FROM ubuntu:22.04

ARG VERSION

ENV DEBIAN_FRONTEND=noninteractive

RUN mkdir -p /usr/share/man/man1 && \
    apt-get update && \
    apt-get install --no-install-recommends -y curl unzip xz-utils git ca-certificates && \
    rm -rf /var/lib/apt/lists/* && \
    rm -rf /var/cache/apt

ENV PATH "/opt/flutter/bin:${PATH}"

RUN cd /opt && \
    curl -s --output - https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_${VERSION}-stable.tar.xz  | tar xJf - -C /opt

RUN git config --global --add safe.directory /opt/flutter && \
    flutter config --no-analytics && \
    flutter config --enable-web && \
    flutter config --no-enable-linux-desktop && \
    flutter precache && \
    flutter doctor && \
    dart --disable-analytics
