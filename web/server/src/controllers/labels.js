const labelService = require('../services/labels');
const {
  BAD_REQUEST,
  NO_CONTENTS,
  VALIDATION_ERROR,
} = require('../common/errorHandler');

class LabelController {
  constructor({ labelService }) {
    this.labelService = labelService;
  }

  add = async (req, res) => {
    const { name, color, description } = req.body;
    try {
      await this.labelService.add({ name, color, description });
      res.status(200).json({ success: true });
    } catch (err) {
      if (err.name === 'SequelizeUniqueConstraintError') {
        return res.status(409).json({ success: false, message: err.message });
      }
      throw err;
    }
  };

  getAll = async (req, res) => {
    const labels = await this.labelService.findAll();
    res.status(200).json(labels);
  };

  getOne = async (req, res) => {
    const { num } = req.params;
    const label = await this.labelService.findOneByNum({ num });
    res.status(200).json(label);
  };

  update = async (req, res) => {
    const {
      params: { num },
      body: payload,
    } = req;
    const [updated] = await this.labelService.update({ num, payload });
    if (!updated) {
      return res.status(404).json({ success: false, message: 'no contents' });
    }
    res.status(200).json({ success: true });
  };

  delete = async (req, res) => {
    const { num } = req.params;
    const deleted = await this.labelService.remove({ num });
    if (!deleted) {
      return res.status(404).json({ success: false, message: 'no contents' });
    }
    res.status(200).json({ success: true });
  };
}

module.exports = new LabelController({ labelService });
