(function() {

  // Credits to https://stackoverflow.com/questions/400212/how-do-i-copy-to-the-clipboard-in-javascript
  function fallbackCopyTextToClipboard(text) {
    var textArea = document.createElement("textarea");
    textArea.value = text;
    // Avoid scrolling to bottom
    textArea.style.top = "0";
    textArea.style.left = "0";
    textArea.style.position = "fixed";
    document.body.appendChild(textArea);
    textArea.focus();
    textArea.select();
    var successful = false;
    try {
      successful = document.execCommand('copy');
    } catch (err) {
      successful = false;
    }
    document.body.removeChild(textArea);
    return successful;
  }

  function copyTextToClipboard(text) {
    if (!navigator.clipboard) {
      fallbackCopyTextToClipboard(text);
    }
    return navigator.clipboard.writeText(text);
  }

  const copyButton = (elm) => {
    const copyBtn = document.createElement('button');
    copyBtn.innerText = "Copy";
    copyBtn.className = "copy-btn";
    copyBtn.onclick = () => {
      const clone = elm.cloneNode(true);
      // remove button
      clone.removeChild(clone.childNodes[clone.childNodes.length-1]);
      copyTextToClipboard(clone.innerText);
    };
    elm.appendChild(copyBtn);
    // elm.parentNode.insertBefore(copyBtn, elm.nextSibling);
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
    const STEP_REGEX = /\/tutorial\/step-(\d+)\.html/;
    const matches = window.location.pathname.match(STEP_REGEX);
    // Actually on a tutorial page
    if (matches) {
      hackMarkdownSections();
    }
  };
})();

window.rerun();
