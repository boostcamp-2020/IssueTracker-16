const labelService = require('../services/labels');

class LabelController {
  constructor({ labelService }) {
    this.labelService = labelService;
  }

  // add(req, res) { }

  // getAll(req, res) { }

  async getOne(req, res) {
    const { num } = req.params;
    const label = await labelService.findOneByNum({ num });
    res.status(200).json(label);
  }

  // update(req, res) { }

  // delete(req, res) { }
}

module.exports = new LabelController({ labelService });
