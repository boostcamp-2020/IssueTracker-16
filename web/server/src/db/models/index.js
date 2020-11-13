'use strict';

const Sequelize = require('sequelize');
const env = process.env.NODE_ENV || 'development';
const config = require('../config/config.js')[env];
const { database, username, password, ...rest } = config;
const db = {
  User: require('./user'),
  OAuth: require('./oAuth'),
  Authorization: require('./authorization'),
  Issue: require('./issue'),
  Comment: require('./comment'),
  Label: require('./label'),
  Milestone: require('./milestone'),
  Image: require('./image'),
};

const sequelize = new Sequelize(database, username, password, rest);

Object.values(db)
  .map(model => model.init(sequelize))
  .forEach(model => model.associate(db));

module.exports = {
  ...db,
  sequelize,
};
