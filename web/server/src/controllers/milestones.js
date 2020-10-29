const milestoneService = require('../services/milestones');

class MilestoneController {
  constructor({ milestoneService }) {
    this.milestoneService = milestoneService;
  }

  add = async (req, res) => {};

  getAll = async (req, res) => {};

  update = async (req, res) => {};

  delete = async (req, res) => {
    const { num } = req.params;
    const deleted = await this.milestoneService.remove({ num });
    if (!deleted) {
      return res.status(404).json({ success: false, message: 'no contents' });
    }
    res.status(200).json({ success: true });
  };
}

module.exports = new MilestoneController({ milestoneService });
