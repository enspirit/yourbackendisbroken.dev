FROM q8s.quadrabee.com/enspirit/startback-web-2.7:0.7 as builder

WORKDIR /app
USER root

COPY Gemfile /app/Gemfile
RUN bundle install
RUN npm install -g sass markdown-it-cli markdown-it-highlightjs

COPY . /app
RUN make clean site

FROM nginx:alpine

COPY --from=builder /app/site /usr/share/nginx/html/

