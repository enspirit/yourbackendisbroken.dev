(function() {

  // Generate unique ids for copy buttons and target elements
  let copyButtonIds = 0;
  const copyButton = (elm) => {
    elm.id = `target-cp-btn-id-${copyButtonIds++}`;
    const copyBtn = document.createElement('button');
    copyBtn.innerText = "Copy";
    copyBtn.className = "copy-btn";
    copyBtn.setAttribute('data-clipboard-target', `#${elm.id}`);
    const cbjs = new ClipboardJS(copyBtn);
    cbjs.on('success', (e) => {
      e.clearSelection();
      setTimeout(() => copyBtn.innerText = "Copy", 1000);
      copyBtn.innerText = "Copied :)";
    });
    elm.parentNode.insertBefore(copyBtn, elm.nextSibling);
  }

  const hackMarkdownSections = function() {
    const bashScripts = document.querySelectorAll('.hljs');
    for (let i = 0; i < bashScripts.length; i++) {
      const element = bashScripts[i];
      if (element.hacked) {
        continue;
      }
      copyButton(element);
    }
  };

  window.rerun = () => {
    const STEP_REGEX = /\/tutorial\//;
    const matches = window.location.pathname.match(STEP_REGEX);
    // Actually on a tutorial page
    if (matches) {
      hackMarkdownSections();
    }
  };
})();

window.rerun();
