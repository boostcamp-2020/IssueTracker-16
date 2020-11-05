const { Label } = require('../db/models');

const labelService = {
  add: async ({ name, color, description }) =>
    Label.create({ name, color, description }),

  findAll: async () => Label.findAll(),

  findOneByNum: async ({ num }) => Label.findByPk(num),

  update: async ({ num, payload }) => Label.update(payload, { where: { num } }),

  remove: async ({ num }) => Label.destroy({ where: { num } }),
};

module.exports = labelService;
