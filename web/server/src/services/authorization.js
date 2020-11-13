const { Authorization } = require('../db/models');

const authorizationService = {
  add: async ({ userNum, oAuthNum, accessToken }) =>
    Authorization.create({ userNum, oAuthNum, accessToken }),
};

module.exports = authorizationService;
