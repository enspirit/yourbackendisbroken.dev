FROM q8s.quadrabee.com/enspirit/startback-web-2.7:0.7 as builder

WORKDIR /app
COPY . /app
USER root

COPY Gemfile /app/Gemfile
RUN bundle install
RUN npm install -g sass

RUN make clean html css

FROM nginx:alpine

COPY --from=builder /app/site/*.css /app/site/*.html /app/scripts/ /usr/share/nginx/html/
