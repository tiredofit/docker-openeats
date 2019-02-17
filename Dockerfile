FROM tiredofit/nodejs/10-alpine
LABEL maintainer="Dave Conroy (dave at tiredofit dot ca)"

### Set Defaults
ENV OPENEATS_API_VERSION=master \
    OPENEATS_WEB_VERSION=master \
    API_PORT=5210 \
    API_WORKERS=5 \
    APPLICATION_NAME=Openeats \
    NODE_ENV=production \
    NODE_LOCALE=en

### Build Application
RUN set -x && \
    ## Install Dependencies
    apk update && \
    apk add -t .openeats-build-deps \
            build-base \
            git \
            libjpeg-turbo-dev \
            mariadb-dev \
            py3-pip \
            python3-dev \
            python2 \
            && \
    \
    apk add -t .openeats-run-deps \
            libjpeg-turbo \
            nginx \
            mariadb-client \
            mariadb-connector-c \
            python3 \
            && \
    \
    mkdir -p /app/ && \
    \
    ## API Installation
    git clone -b $OPENEATS_API_VERSION https://github.com/open-eats/openeats-api.git /app/api && \
    cd /app/api && \
    pip3 install -U -r ./base/requirements.txt && \
    \
    ## Web Installation
    git clone  -b $OPENEATS_WEB_VERSION https://github.com/open-eats/openeats-web.git /usr/src/web && \
    set -x && \
    cd /usr/src/web && \
    yarn install --pure-lockfile --production=false && \
    mkdir -p /app/web && \
    \
    ## Cleanup
    #rm -rf /usr/src/* && \
    rm -rf /app/api/.git* /app/api/travis.yml /app/api/Dockerfile /app/api/test* && \
    apk del .openeats-build-deps && \
    rm -rf /tmp/* /var/cache/apk/* && \
    rm -rf /root/.cache /root/.config /root/.node-gyp /root/.subversion && \
    ln -s /usr/bin/python3 /usr/bin/python && \
    ln -s /app/data/static /app/api/static-files && \
    ln -s /app/data/media /app/api/site-media && \
    ln -s /app/data/media /app/web/site-media

### Networking Configuration
EXPOSE 80

### Add Assets
ADD install /
