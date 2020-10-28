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

  async delete(req, res) {
    const { num } = req.params;
    const deleted = await labelService.remove({ num });
    if (deleted) {
      res.status(200).json({ success: true });
    } else {
      res.status(404).json({ success: false });
    }
  }
}

module.exports = new LabelController({ labelService });
