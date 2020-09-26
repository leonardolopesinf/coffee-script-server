// @flow
var app;

import express from 'express';

app = express();

app.listen(3000, function() {
  return console.log('Servidor rodando na porta 3000');
});
