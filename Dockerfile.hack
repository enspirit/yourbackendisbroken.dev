FROM q8s.quadrabee.com/enspirit/startback-web-2.7:0.7

WORKDIR /app
USER root
RUN npm install -g sass
