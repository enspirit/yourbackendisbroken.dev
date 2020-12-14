const express = require('express');
const bodyParser = require('body-parser');
const { createProxyMiddleware } = require('http-proxy-middleware');

const app = express();
const port = 8080;

app.use(bodyParser.json());
app.use(express.static('public'));

app.get('/ping', (req, res) => {
  res.send('pong');
})

app.use(createProxyMiddleware({
  target: 'http://localhost:9001',
  changeOrigin: true,
  ws: true
}));

app.listen(port, () => {
  console.log(`Tutorial API listening at http://0.0.0.0:${port}`);
});
