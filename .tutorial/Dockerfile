FROM enspirit/webspicy

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
COPY .tutorial/supervisord.conf /etc/
COPY .tutorial/entrypoint.sh /
COPY bin/* /usr/bin/
COPY .tutorial/banner.txt /etc/banner.txt

ENTRYPOINT ["/entrypoint.sh"]
