const express = require('express');
const { createProxyMiddleware } = require('http-proxy-middleware');

const app = express();
const http = require('http').createServer(app);
const port = 8080;

// Serve website (see Dockerfile)
app.use(express.static('public'));

app.use(createProxyMiddleware({
  target: 'http://localhost:9001',
  changeOrigin: true,
  ws: true
}));

http.listen(port, () => {
  console.log(`Tutorial API listening at http://0.0.0.0:${port}`);
});
