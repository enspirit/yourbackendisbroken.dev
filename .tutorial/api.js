const express = require('express');
const bodyParser = require('body-parser');
const { createProxyMiddleware } = require('http-proxy-middleware');

const app = express();
const http = require('http').createServer(app);
const port = 8080;

app.use(bodyParser.json());
app.use(express.static('public'));

app.get('/ping', (req, res) => {
  res.send('pong');
});

const io = require("socket.io")(http, {
  cors: {
    origin: "https://yourbackendisbroken.dev",
    methods: ["GET", "POST"]
  }
});

io.on('connection', socket => {
  socket.emit('ping');

  socket.on('previous', () => {
    console.log('User wants previous');
  });

  socket.on('next', () => {
    console.log('User wants next');
  });

  socket.on('run', (cmd) => {
    console.log('User wants to run', cmd);
  });
});

app.use(createProxyMiddleware({
  target: 'http://localhost:9001',
  changeOrigin: true,
  ws: true
}));

http.listen(port, () => {
  console.log(`Tutorial API listening at http://0.0.0.0:${port}`);
});
