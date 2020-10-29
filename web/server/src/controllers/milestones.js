const milestoneService = require('../services/milestones');

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
    await this.milestoneService.add({ title, dueDate, description });
    res.status(200).json({ success: true });
  };

  getAll = async (req, res) => {};

  update = async (req, res) => {};

  delete = async (req, res) => {};
}

module.exports = new MilestoneController({ milestoneService });
