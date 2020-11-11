const { User } = require('../db/models');
const { LOGIN_FAILED, JOIN_FAILED } = require('../common/errorHandler');

const userService = {
  login: async ({ id, password }) => {
    const user = await User.findOne({ where: { id } });
    const verify = (user, pwd) => user && user.password === pwd;

    if (!verify(user, password)) {
      throw new Error(LOGIN_FAILED);
    }
    return user;
  },

  join: async ({ id, password, name, imageUrl }) => {
    const user = await User.findOne({ where: { id } });

    if (user) {
      throw new Error(JOIN_FAILED);
    }
    const newUser = await User.create({ id, password, name, imageUrl });
    delete newUser.dataValues.password;
    return newUser;
  },

  findAll: async () =>
    User.findAll({ attributes: ['num', 'id', 'name', 'imageUrl'] }),
};

module.exports = userService;
