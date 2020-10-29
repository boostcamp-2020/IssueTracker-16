const labelService = require('../services/labels');
const { NO_CONTENTS } = require('../common/errorHandler');

class LabelController {
  constructor({ labelService }) {
    this.labelService = labelService;
  }

  add = async (req, res) => {
    const { name, color, description } = req.body;
    await this.labelService.add({ name, color, description });
    res.status(200).json({ success: true });
  };

  getAll = async (req, res) => {
    const labels = await this.labelService.findAll();
    res.status(200).json(labels);
  };

  getOne = async (req, res) => {
    const { num } = req.params;
    const label = await this.labelService.findOneByNum({ num });
    if (!label) {
      throw new Error(NO_CONTENTS);
    }
    res.status(200).json(label);
  };

  update = async (req, res) => {
    const {
      params: { num },
      body: payload,
    } = req;
    const [updated] = await this.labelService.update({ num, payload });
    if (!updated) {
      throw new Error(NO_CONTENTS);
    }
    res.status(200).json({ success: true });
  };

  delete = async (req, res) => {
    const { num } = req.params;
    const deleted = await this.labelService.remove({ num });
    if (!deleted) {
      throw new Error(NO_CONTENTS);
    }
    res.status(200).json({ success: true });
  };
}

module.exports = new LabelController({ labelService });
