const milestoneService = require('../services/milestones');
const {
  BAD_REQUEST,
  NO_CONTENTS,
  VALIDATION_ERROR,
} = require('../common/errorHandler');

class MilestoneController {
  constructor({ milestoneService }) {
    this.milestoneService = milestoneService;
  }

  add = async (req, res) => {
    const { title, dueDate, description } = req.body;
    if (isNaN(new Date(dueDate))) {
      return res
        .status(400)
        .json({ success: false, message: 'Invalid date type' });
    }
    try {
      await this.milestoneService.add({ title, dueDate, description });
      res.status(200).json({ success: true });
    } catch (err) {
      if (err.name === 'SequelizeUniqueConstraintError') {
        return res.status(409).json({ success: false, message: err.message });
      }
      throw err;
    }
  };

  getAll = async (req, res) => {
    const milestones = await this.milestoneService.findAll();
    res.status(200).json(milestones);
  };

  update = async (req, res) => {
    const {
      params: { num },
      body: payload,
    } = req;
    const [updated] = await this.milestoneService.update({ num, payload });
    if (!updated) {
      throw new Error(NO_CONTENTS);
    }
    res.status(200).json({ success: true });
  };

  delete = async (req, res) => {
    const { num } = req.params;
    const deleted = await this.milestoneService.remove({ num });
    if (!deleted) {
      throw new Error(NO_CONTENTS);
    }
    res.status(200).json({ success: true });
  };
}

module.exports = new MilestoneController({ milestoneService });
