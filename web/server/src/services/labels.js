const { Label } = require('../db/models');

class LabelService {
  constructor({ Label }) {
    this.Label = Label;
  }

  async findOneByNum({ num }) {
    return this.Label.findByPk(num);
  }

  async remove({ num }) {
    return this.Label.destroy({ where: { num } });
  }
}

module.exports = new LabelService({ Label });
