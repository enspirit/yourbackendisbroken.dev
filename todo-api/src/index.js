import express from 'express';
import { version } from '../package.json';
import bodyParser from 'body-parser';

const app = express();
const port = 3000;
app.use(bodyParser.json());

app.get('/version', (req, res) => {
  res.send({ name: 'TODOS API', version });
});

app.listen(port, () => {
  console.log(`API listening at http://0.0.0.0:${port}`);
});
