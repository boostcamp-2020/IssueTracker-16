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
}

module.exports = new LabelService({ Label });
