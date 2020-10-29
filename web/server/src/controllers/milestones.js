const milestoneService = require('../services/milestones');

class MilestoneController {
  constructor({ milestoneService }) {
    this.milestoneService = milestoneService;
  }

  add = async (req, res) => {};

  getAll = async (req, res) => {
    const milestones = await this.milestoneService.findAll();
    res.status(200).json(milestones);
  };

  update = async (req, res) => {};

  delete = async (req, res) => {};
}

module.exports = new MilestoneController({ milestoneService });
