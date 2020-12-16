(function() {
  const socket = io('http://localhost:8080');

  const sendCmd = function(cmd, payload) {
    socket.emit(cmd, payload);
  };

  const setStep = (number) => {
    sendCmd('setStep', number);
  };

  const hackButtons = function() {
    // Next & previous buttons
    const prevBtns = document.getElementsByClassName('btn prev')
    const nextBtns = document.getElementsByClassName('btn next')
    const btns = [].concat(
      Array.prototype.slice.call(prevBtns),
      Array.prototype.slice.call(nextBtns)
    );

    btns.forEach((btn) => {
      if (btn.hacked) {
        return;
      }
      btn.addEventListener('click', function(e) {
        const target = this.attributes.href.value;
        const regex = /tutorial\/step-([\d/+])/;
        const match = target.match(regex);
        if (match) {
          const stepNumber = match[1];
          setStep(stepNumber);
        }
      });
      btn.hacked = true;
    });
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
    const STEP_REGEX = /\/tutorial\/step-(\d+)\.html/;
    const matches = window.location.pathname.match(STEP_REGEX);
    // Actually on a tutorial page
    if (matches) {
      const stepNumber = matches[1];
      setStep(stepNumber);
    }
  };

  socket.on('ping', () => {
    window.isTutoConnected = true;
    ensureTutoMode();
  });
})();

window.rerun();
