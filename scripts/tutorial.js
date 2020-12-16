// Next button

const nextBtns = document.getElementsByClassName('btn next')


for (let i = 0; i < nextBtns.length; i++) {
  nextBtns[i].addEventListener('click', () => {
    alert('Clicked');
  });
};


// Prev button

const prevBtns =  document.getElementsByClassName('btn prev')

for (let i = 0; i < prevBtns.length; i++) {
  prevBtns[i].addEventListener('click', () => {
    alert('Clicked');
  });
};


//   Fetch

const changePage = () => {
  e.preventDefault();
  fetch('http://madeupsite.com/', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify(data)
  })
  .then(res => res.json())
  .then(data => console.log('success', data));
};
