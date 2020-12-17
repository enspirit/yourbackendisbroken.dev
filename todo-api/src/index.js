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
  const found = getTodo(req.params.id);
  if (found) {
    res.send(found);
  } else {
    res.sendStatus(404);
  }
});

const ensureValidTodo = (todo, idRequired=true) => {
  const fields = ["id", "description"];
  // Check for extra prop
  for (const p in todo) {
    if (!fields.includes(p)) {
      throw new Error(`Invalid Todo: unknown property ${p}`);
    }
  }
  // Check for missing props
  for (const p of fields) {
    if (p == "id" && !idRequired) {
      continue;
    }
    if (!todo[p]) {
      throw new Error(`Invalid Todo: missing property ${p}`);
    }
  }
}

app.post('/todos', (req, res) => {
  const todo = req.body;
  try {
    ensureValidTodo(todo, false);
  } catch (err) {
    return res.send(400, { err });
  }
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
