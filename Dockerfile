ARG ALPINE=3.12
FROM alpine:${ALPINE} AS fetcher
RUN apk add  --no-cache \
        ca-certificates \
        coreutils \
        wget
ARG DOCKER_TAG
RUN wget https://github.com/gohugoio/hugo/releases/download/v${DOCKER_TAG}/hugo_extended_${DOCKER_TAG}_Linux-64bit.tar.gz \
    && wget https://github.com/gohugoio/hugo/releases/download/v${DOCKER_TAG}/hugo_${DOCKER_TAG}_checksums.txt \
    && sha256sum --ignore-missing -c hugo_${DOCKER_TAG}_checksums.txt \
    && tar -zxvf hugo_extended_${DOCKER_TAG}_Linux-64bit.tar.gz

FROM alpine:${ALPINE}
RUN apk add --no-cache \
        libc6-compat \
        libstdc++ \
        py3-pygments \
        py3-docutils
COPY --from=fetcher /hugo /usr/bin/hugo
ENTRYPOINT ["/usr/bin/hugo"]
