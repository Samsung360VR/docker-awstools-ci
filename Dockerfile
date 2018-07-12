FROM alpine:3.7


RUN apk add --update && \
    apk add nodejs tar curl py-pygments git bash && \
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

ENV HUGO_VERSION 0.43
ENV HUGO_BINARY hugo_${HUGO_VERSION}_Linux-64bit

# Download and Install hugo
ADD https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/${HUGO_BINARY}.tar.gz /usr/local/

RUN tar xzf /usr/local/${HUGO_BINARY}.tar.gz -C /usr/local/bin/ \
	&& rm /usr/local/${HUGO_BINARY}.tar.gz \
  && hugo version
