const { Label } = require('../db/models');

class LabelService {
  constructor({ Label }) {
    this.Label = Label;
  }

  add = async ({ name, color, description }) =>
    this.Label.create({ name, color, description });

  findAll = async () => this.Label.findAll();

  findOneByNum = async ({ num }) => this.Label.findByPk(num);

  update = async ({ num, payload }) =>
    this.Label.update(payload, { where: { num } });

  remove = async ({ num }) => this.Label.destroy({ where: { num } });
}

module.exports = new LabelService({ Label });
