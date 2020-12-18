const express = require('express');
const { version } = require('../package.json');
const bodyParser = require('body-parser');
const morgan = require('morgan');

const app = express();
const port = 3000;

const prepopulate = () => {
  return [{
    id: 1,
    description: 'Read yourwebsiteisbrokend.dev'
  }, {
    id: 2,
    description: 'Install webspicy, and wear your mask'
  }, {
    id: 3,
    description: 'Write your first specification'
  }, {
    id: 4,
    description: 'Use output schemas'
  }, {
    id: 5,
    description: 'Use assertions on output'
  }, {
    id: 6,
    description: 'Use counter examples'
  }];
};

let todos = prepopulate();

function getTodos() {
  return todos;
}

function getTodo(id) {
  return getTodos().find(todo => todo.id == id);
}

function nextId() {
  const ids = getTodos().map(t => t.id);
  const lastId = Math.max(...ids);
  return lastId + 1;
}

function addTodo(todo) {
  const id = nextId();
  getTodos().push({
    id: id,
    ...todo
  });
  return id;
}

function removeTodo(id) {
  return getTodos().splice(id, 1);
}

app.use(bodyParser.json());
app.use(morgan('combined'));

app.get('/version', (req, res) => {
  res.send({ name: 'TODOS API', version });
});

app.get('/todos', (req, res) => {
  res.send(getTodos());
});

app.get('/todos/:id', (req, res) => {
  res.send(getTodo(req.params.id));
});

app.post('/todos', (req, res) => {
  const todo = req.body;
  const id = addTodo(todo);
  res.send(getTodo(id));
});

app.delete('/todos/:id', (req, res) => {
  const removed = removeTodo(req.params.id);
  if (typeof removed !== 'undefined') {
    if (removed.length > 0) {
      res.sendStatus(204);
    } else {
      res.sendStatus(404);
    }
  } else {
    res.sendStatus(500);
  }
});

app.post('/reset', (req, res) => {
  todos = prepopulate();
  res.send(204);
});

app.listen(port, () => {
  console.log(`API listening at http://0.0.0.0:${port}`);
});
