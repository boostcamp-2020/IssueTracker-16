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

  async remove({ num }) {
    return this.Label.destroy({ where: { num } });
  }
  async add({ name, color, description }) {
    return this.Label.create({ name, color, description });
  }
}

module.exports = new LabelService({ Label });
