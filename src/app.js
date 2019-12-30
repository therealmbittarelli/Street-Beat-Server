require('dotenv').config();
const express = require('express');
const morgan = require('morgan');
const cors = require('cors');
const helmet = require('helmet');
const { NODE_ENV } = require('./config');
const bandsRouter = require('./bands/bands-router');
const usersRouter = require('./users/users-router');
const authRouter = require('./auth/auth-router');
// const setlistsRouter = require('./setlists/setlists-router');
// const songsRouter = require('./songs/songs-router');

const app = express();

app.use(morgan((NODE_ENV === 'production') ? 'tiny' : 'common', {
  skip: () => NODE_ENV === 'test',
}));
app.use(cors());
app.use(helmet());

app.use('/api/bands', bandsRouter);
app.use('/api/users', usersRouter);
app.use('/api/auth', authRouter);
// app.use('/api/setlists', setlistsRouter);
// app.use('/api/songs', songsRouter);
const textParser = express.text();
app.route('/api').post(textParser, (req, res, next) => {
  console.log('received: ', req.body);
  res.send('hello world. -server');
});

app.use((error, req, res, next) => {
  let response;
  if (process.env.NODE_ENV === 'production') {
    response = { error: { message: 'server error' } };
  } else {
    response = { error };
  }
  res.status(500).json(response);
});

module.exports = app;