import express from 'express';
import { version } from '../package.json';
import bodyParser from 'body-parser';
import morgan from 'morgan';

const app = express();
const port = 3000;
const todos = [{
    id: 1, description: "one"
  }, {
    id: 2, description: "two"
  }, {
    id: 3, description: "three"
  }, {
    id: 4, description: "four"
  }, {
    id: 5, description: "five"
  }
];

app.use(bodyParser.json());
app.use(morgan('combined'))

app.get('/version', (req, res) => {
  res.send({ name: 'TODOS API', version });
});

app.get('/todos', (req, res) => {
  res.send(todos);
});

app.get('/todos/:id', (req, res) => {
  const found = todos.find(todo => todo.id == req.params.id);
  if (found) {
    res.send(found);
  } else {
    res.sendStatus(404);
  }
});

app.listen(port, () => {
  console.log(`API listening at http://0.0.0.0:${port}`);
});
