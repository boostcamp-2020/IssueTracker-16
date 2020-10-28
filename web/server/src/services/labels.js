const { Label } = require('../db/models');

class LabelService {
  constructor({ Label }) {
    this.Label = Label;
  }

  async findOneByNum({ num }) {
    return this.Label.findByPk(num);
  }
}

module.exports = new LabelService({ Label });
