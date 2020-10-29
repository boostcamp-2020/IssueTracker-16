const milestoneService = require('../services/milestones');

class MilestoneController {
  constructor({ milestoneService }) {
    this.milestoneService = milestoneService;
  }

  add = async (req, res) => {};

  getAll = async (req, res) => {};

  update = async (req, res) => {
    const {
      params: { num },
      body: payload,
    } = req;
    const [updated] = await this.milestoneService.update({ num, payload });
    if (!updated) {
      return res.status(404).json({ success: false, message: 'no contents' });
    }
    res.status(200).json({ success: true });
  };

  delete = async (req, res) => {};
}

module.exports = new MilestoneController({ milestoneService });
