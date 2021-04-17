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
        graphviz \
        libc6-compat \
        libstdc++ \
        nodejs \
        openjdk8-jre \
        py3-pygments \
        py3-docutils \
        ruby \
        ruby-json \
        yarn \
 && yarn global add \
        autoprefixer \
        postcss \ 
        postcss-cli \
  && gem install \
        asciidoctor \
        asciidoctor-diagram \
        asciidoctor-html5s        
COPY --from=fetcher /hugo /usr/bin/hugo
COPY bin/ /usr/local/bin/
ENTRYPOINT ["/usr/local/bin/run-hugo"]
