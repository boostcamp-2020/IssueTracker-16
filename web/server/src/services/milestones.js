const { Milestone, sequelize } = require('../db/models');
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

const milestoneService = {
  add: async ({ title, dueDate, description }) =>
    Milestone.create({ title, dueDate, description }),

  findAll: async () => Milestone.findAll(option),

  findOneByNum: async ({ num }) => Milestone.findByPk(num, option),

  update: async ({ num, payload }) =>
    Milestone.update(payload, { where: { num } }),

  remove: async ({ num }) => Milestone.destroy({ where: { num } }),
};

module.exports = milestoneService;
