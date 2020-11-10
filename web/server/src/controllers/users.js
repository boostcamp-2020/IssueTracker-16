const userService = require('../services/users');
const jwt = require('../common/jwt');
const { CREATED, OK } = require('../common/status');

const userController = {
  login: async (req, res) => {
    const { id, password } = req.body;
    const user = await userService.login({ id, password });
    const token = await jwt.sign(user);
    res.status(OK).json({ success: true, token });
  },

  join: async (req, res) => {
    const { id, password, name, imageUrl } = req.body;
    const user = await userService.join({ id, password, name, imageUrl });
    delete user.dataValues.password;
    res.status(CREATED).json({ success: true, user });
  },

  auth: async (req, res) => {
    const { token } = req.query;
    const decoded = await jwt.authentication(token);
    res.status(OK).json({ success: true, user: decoded });
  },

  getAll: async (req, res) => {
    const users = await userService.findAll();
    res.status(OK).json(users);
  },
};

module.exports = userController;
