FROM ubuntu:16.04


RUN apk add --update && \
    apk add --virtual .builtin-utils curl bash && \
    apk add --virtual .awscli-runtime-deps python \
         && apk add --virtual .awscli-build-deps py-pip \
         && pip install awscli \
         && apk del --purge .awscli-build-deps && \
    set -ex \
      && curl -sSL https://storage.googleapis.com/kubernetes-helm/helm-v2.9.1-linux-amd64.tar.gz | tar xz \
      && mv linux-amd64/helm /usr/local/bin/helm \
      && rm -rf linux-amd64 \
      && helm init --client-only
