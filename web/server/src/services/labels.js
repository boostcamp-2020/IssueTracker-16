const { Label } = require('../db/models');

class LabelService {
  constructor({ Label }) {
    this.Label = Label;
  }

  async findAll() {
    return this.Label.findAll();
  }

  async findOneByNum({ num }) {
    return this.Label.findByPk(num);
  }

  async update({ num, payload }) {
    return this.Label.update(payload, { where: { num } });
  }

  async remove({ num }) {
    return this.Label.destroy({ where: { num } });
  }
}

module.exports = new LabelService({ Label });
