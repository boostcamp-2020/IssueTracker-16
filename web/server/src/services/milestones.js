const { Milestone, Issue, sequelize } = require('../db/models');
const { findAllMilestones } = require('../common/query');

class MilestoneService {
  constructor({ Milestone, Issue, sequelize }) {
    this.Milestone = Milestone;
    this.Issue = Issue;
    this.sequelize = sequelize;
  }

  add = ({ title, dueDate, description }) =>
    this.Milestone.create({ title, dueDate, description });

  findAll = async () => {
    const [milestones] = await this.sequelize.query(findAllMilestones);
    return milestones;
  };

  update = async ({ num, payload }) =>
    this.Milestone.update(payload, { where: { num } });

  remove = async ({ num }) => this.Milestone.destroy({ where: { num } });
}

module.exports = new MilestoneService({ Milestone, Issue, sequelize });
