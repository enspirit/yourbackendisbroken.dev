FROM gitpod/workspace-full

USER root

COPY bin/next bin/previous /usr/bin/

USER gitpod

ENV RUBYOPT="-W0"
RUN bash -lc "gem install webspicy"
