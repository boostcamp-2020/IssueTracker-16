require('dotenv').config();
const express = require('express');
const cookieParser = require('cookie-parser');
const logger = require('morgan');

const { sequelize } = require('./db/models');
const apiRouter = require('./routes/index');

sequelize.sync();
const app = express();

app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());

app.use('/api', apiRouter);

app.use((err, req, res, next) => {
  const { status, message } = err;
  res.status(status).json({ success: false, message });
});

module.exports = app;
