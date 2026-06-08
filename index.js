const express = require('express');
const app = express();
const PORT = 3000;

app.get('/', (req, res) => {
  res.send('pong');
});

app.get('/health', (req, res) => {
  res.json({ status: 'OK', message: 'Application en bonne sante' });
});

app.listen(PORT, () => {
  console.log(`Serveur demarre sur le port ${PORT}`);
});

module.exports = app;
