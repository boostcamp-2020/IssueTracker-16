const { User } = require('../db/models');
const { LOGIN_FAILED } = require('../common/errorHandler');
const jwt = require('../common/jwt');

const userService = {
  login: async ({ id, password }) => {
    const user = await User.findOne({ where: { id } });
    const verify = (user, pwd) => user.password === pwd;

    if (!user) {
      throw new Error(LOGIN_FAILED);
    }
    if (!verify(user, password)) {
      throw new Error(LOGIN_FAILED);
    }
    return jwt.sign(user);
  },
};

module.exports = userService;
