const express = require('express');
const { createProxyMiddleware } = require('http-proxy-middleware');
const { exec } = require('child_process');

const app = express();
const http = require('http').createServer(app);
const port = 8080;
const TMUX_SESSION = process.env.YBIB_TMUX_SESS;

// Serve website (see Dockerfile)
app.use(express.static('public'));

// Socket.io for public website <> tutorial communication
const io = require("socket.io")(http, {
  cors: {
    origin: "https://yourbackendisbroken.dev",
    methods: ["GET", "POST"]
  }
});

// Send commands to the main terminal of the tutorial
// (for gitpod/docker experiences)
const runCmd = (cmd) => {
  console.log('running cmd > ', cmd);
  // // Ctrl-C to make sure no user-typed command is pretyped
  exec(`tmux send-keys -t ${TMUX_SESSION}.0 C-c`);
  // // Send the actual command
  // // TODO @llambeau: potential security issue here, even though we are in a docker
  // //  controled env
  exec(`tmux send-keys -t ${TMUX_SESSION}.0 "${cmd}" ENTER`);
};

// The public website pings 'localhost' to see if a tuto is running.
// When a succesful connection is established, the website's UX is changing
// slightly so that the tutorial shell is following the web-based tutorial
io.on('connection', socket => {
  // Confirm to the website we are there
  socket.emit('ping');

  // make sure the tutorial is on a specific step (aka: git tag)
  socket.on('setStep', (num) => {
    console.log('socketio#steStep', num);
    runCmd(`./bin/step ${num}`);
  });

  socket.on('runCmd', (cmd) => {
    runCmd(cmd);
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
