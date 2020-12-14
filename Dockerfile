FROM alpine as ttyecho

RUN apk add gcc libc-dev

# ttyecho
COPY .tutorial/ttyecho.c /tmp
RUN gcc -o /usr/bin/ttyecho /tmp/ttyecho.c

FROM enspirit/webspicy

##
ARG YBIB_REPO
ARG YBIB_BRANCH
ENV YBIB_BRANCH=${YBIB_BRANCH}
ENV YBIB_REPO=${YBIB_REPO}
ENV DOCKER_ENV=1

##
RUN apk add --no-cache bash git curl supervisor netcat-openbsd nodejs nodejs-npm

# disable warnings in ruby
ENV RUBYOPT="-W0"

# Install todos-api's
WORKDIR /opt/node_deps/
COPY todo-api/package.json ./
RUN npm install
ENV NODE_PATH="/opt/node_deps/node_modules/"
ENV PATH="$PATH:/opt/node_deps/node_modules/.bin"

WORKDIR /ybib

# ttyecho
COPY --from=ttyecho /usr/bin/ttyecho /usr/bin

# Supervisord, entrypoint, scripts, ...
RUN mkdir -p /run/nginx/ /usr/share/nginx/html
COPY .tutorial/supervisord.conf /etc/
COPY .tutorial/curlrc $HOME/.curlrc
COPY .tutorial/entrypoint.sh .tutorial/start-api.sh /

# Tutorial api & webpages
RUN mkdir -p /tutorial
COPY .tutorial/api.js /tutorial/
COPY .tutorial/index.html .tutorial/logger.html /tutorial/public/

# Copy website
COPY --from=enspirit/yourbackendisbroken:website /usr/share/nginx/html /tutorial/public/website

ENTRYPOINT ["/entrypoint.sh"]
