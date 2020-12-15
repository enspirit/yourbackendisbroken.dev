FROM gitpod/workspace-full

USER root

COPY bin/next bin/previous /usr/bin/

USER gitpod

ENV RUBYOPT="-W0"
RUN bash -lc "gem install webspicy"

COPY .tutorial/index.html /usr/share/nginx/html

ENV NGINX_DOCROOT_IN_REPO=".tutorial"
