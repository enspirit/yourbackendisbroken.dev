(function() {
  const socket = io('http://localhost:8080');

  const hackButtons = function() {
    // Next buttons
    const nextBtns = document.getElementsByClassName('btn next')
    for (let i = 0; i < nextBtns.length; i++) {
      const btn = nextBtns[i];
      if (btn.hacked) {
        continue;
      }
      btn.addEventListener('click', () => {
        sendCmd('next');
      });
      btn.hacked = true;
    };


    // Prev buttons
    const prevBtns = document.getElementsByClassName('btn prev')
    for (let i = 0; i < prevBtns.length; i++) {
      const btn = prevBtns[i];
      if (btn.hacked) {
        continue;
      }
      btn.addEventListener('click', () => {
        sendCmd('previous');
      });
      btn.hacked = true;
    };
  };

  const sendCmd = function(cmd, payload) {
    socket.emit(cmd, payload);
  };

  const ensureTutoMode = () => {
    if (!window.isTutoConnected) {
      return;
    }
    if (!window.greeted) {
      console.log('Oh! you are running our tutorial...');
      console.log('Let\'s make sure the previous/next buttons of this page are hooked to it.');
      window.greeted = true;
    }

    hackButtons();
  };

  window.rerun = () => {
    ensureTutoMode();
  };

  socket.on('ping', () => {
    window.isTutoConnected = true;
    ensureTutoMode();
  });
})();

window.rerun();
