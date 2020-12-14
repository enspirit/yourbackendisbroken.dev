FROM enspirit/webspicy

##
ARG YBIB_REPO
ARG YBIB_BRANCH
ENV YBIB_BRANCH=${YBIB_BRANCH}
ENV YBIB_REPO=${YBIB_REPO}
ENV DOCKER_ENV=1

##
RUN apk add bash git curl nginx supervisor netcat-openbsd nodejs nodejs-npm

# disable warnings in ruby
ENV RUBYOPT="-W0"

# Install todos-api's
WORKDIR /opt/node_deps/
COPY todo-api/package.json ./
RUN npm install
ENV NODE_PATH="/opt/node_deps/node_modules/"
ENV PATH="$PATH:/opt/node_deps/node_modules/.bin"

WORKDIR /ybib

# Supervisord, entrypoint, scripts, ...
RUN mkdir -p /run/nginx/ /usr/share/nginx/html
COPY .tutorial/supervisord.conf /etc/
COPY .tutorial/entrypoint.sh /
COPY bin/* /usr/bin/
COPY .tutorial/nginx.conf /etc/nginx/conf.d/default.conf
COPY .tutorial/index.html /usr/share/nginx/html

ENTRYPOINT ["/entrypoint.sh"]
