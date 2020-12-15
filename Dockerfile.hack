FROM q8s.quadrabee.com/enspirit/startback-web-2.7:0.7

WORKDIR /app
USER root

COPY Gemfile /app/Gemfile
RUN bundle install
RUN npm install -g sass markdown-it-cli
