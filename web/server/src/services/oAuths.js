const { OAuth } = require('../db/models');

const oAuthService = {
  findOne: async ({ service }) => OAuth.findOne({ where: { name: service } }),
};

module.exports = oAuthService;
