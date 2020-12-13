FROM ruby:2.7 AS html

WORKDIR /app
COPY . /app
RUN make clean html

FROM node:latest AS css

RUN npm install -g sass

WORKDIR /app
COPY . /app
RUN make clean css

FROM nginx:alpine

COPY --from=html /app/*.html /app/scripts/ /usr/share/nginx/html/
COPY --from=css /app/*.css /usr/share/nginx/html/

COPY --from=html /app/index.html /usr/share/nginx/html/welcome.html
COPY --from=html /app/waiting.html /usr/share/nginx/html/index.html