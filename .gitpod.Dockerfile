FROM gitpod/workspace-full

USER root

# Install todos-api's
COPY todo-api/package.json /opt/node_deps/
RUN cd /opt/node_deps && npm install
ENV NODE_PATH="$NODE_PATH:/opt/node_deps/node_modules/"
ENV PATH="$PATH:/opt/node_deps/node_modules/.bin"

USER gitpod

ENV RUBYOPT="-W0"
RUN bash -lc "gem install webspicy"

COPY .tutorial/index.html /usr/share/nginx/html
COPY .gitpod/nginx.conf /etc/nginx/nginx.conf

ENV NGINX_DOCROOT_IN_REPO=".tutorial"
