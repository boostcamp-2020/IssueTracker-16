const userService = require('../services/users');
const { CREATED, OK } = require('../common/status');

const userController = {
  login: async (req, res) => {
    const { id, password } = req.body;
    const token = await userService.login({ id, password });
    res.status(OK).json({ success: true, token });
  },

  join: async (req, res) => {
    const { id, password, name, imageUrl } = req.body;
    const user = await userService.join({ id, password, name, imageUrl });
    delete user.dataValues.password;
    res.status(CREATED).json({ success: true, user });
  },
};

module.exports = userController;
