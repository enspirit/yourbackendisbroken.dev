FROM enspirit/webspicy

# install curl, nginx, supervisor, netcat, node
RUN apt-get update && \
  apt-get install -y curl nginx supervisor netcat && \
  curl -sL https://deb.nodesource.com/setup_14.x | bash && \
  apt-get install -y nodejs && \
  apt-get clean autoclean && \
  apt-get autoremove --yes && \
  rm -rf /var/lib/{apt,dpkg,cache,log}/

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
COPY .tutorial/supervisord.conf /etc/supervisor/conf.d/
COPY .tutorial/entrypoint.sh /
COPY bin/* /usr/bin/
COPY .tutorial/banner.txt /etc/banner.txt

ENTRYPOINT ["/entrypoint.sh"]
