'use strict';

const Sequelize = require('sequelize');
const env = process.env.NODE_ENV || 'development';
const config = require('../config/config.js')[env];
const { database, username, password, ...rest } = config;
const db = {
  User: require('./user'),
  OAuth: require('./oAuth'),
  OAuthUser: require('./oAuthUser'),
  Issue: require('./issue'),
  Reply: require('./reply'),
  Label: require('./label'),
  Milestone: require('./milestone'),
  IssueLabel: require('./issueLabel'),
  Assignee: require('./assignee'),
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
