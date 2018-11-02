FROM alpine:3.8
LABEL maintainer="Vladimir Stafievsky <vladimir.stafievsky@protocol.one>"

ENV KUBECTL_VERSION v1.12.2
ENV HELM_VERSION 2.11.0
ENV HELM_FILENAME helm-v${HELM_VERSION}-linux-amd64.tar.gz

RUN apk add --no-cache --virtual .deps curl bash

RUN set -ex \
    && curl -sSL https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl \
    && chmod +x /usr/local/bin/kubectl

RUN set -ex \
    && curl -sSL https://storage.googleapis.com/kubernetes-helm/${HELM_FILENAME} | tar xz \
    && mv linux-amd64/helm /usr/local/bin/helm \
    && rm -rf linux-amd64

RUN helm init --client-only

CMD ["helm"]