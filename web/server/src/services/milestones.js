const { Milestone, Issue, sequelize } = require('../db/models');
const { countOpenedIssues, countClosedIssues } = require('../common/query');

const option = {
  attributes: {
    include: [
      [sequelize.literal(countOpenedIssues), 'openedIssues'],
      [sequelize.literal(countClosedIssues), 'closedIssues'],
    ],
  },
  group: ['num'],
};

class MilestoneService {
  constructor({ Milestone, Issue, sequelize }) {
    this.Milestone = Milestone;
    this.Issue = Issue;
    this.sequelize = sequelize;
  }

  add = ({ title, dueDate, description }) =>
    this.Milestone.create({ title, dueDate, description });

  findAll = async () => this.Milestone.findAll(option);

  findOneByNum = async ({ num }) => this.Milestone.findByPk(num, option);

  update = async ({ num, payload }) =>
    this.Milestone.update(payload, { where: { num } });

  remove = async ({ num }) => this.Milestone.destroy({ where: { num } });
}

module.exports = new MilestoneService({ Milestone, Issue, sequelize });
