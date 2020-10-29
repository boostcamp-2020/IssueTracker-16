const { Milestone, Issue, sequelize } = require('../db/models');
const { findAllMilestones } = require('../common/query');

class MilestoneService {
  constructor({ Milestone, Issue, sequelize }) {
    this.Milestone = Milestone;
    this.Issue = Issue;
    this.sequelize = sequelize;
  }

  add = async () => this.Milestone.create();

  findAll = async () => {
    const [milestones] = await this.sequelize.query(findAllMilestones);
    return milestones;
  };

  update = async () => this.Milestone.update();

  remove = async () => this.Milestone.destroy();
}

module.exports = new MilestoneService({ Milestone, Issue, sequelize });
