const { Milestone } = require('../db/models');

class MilestoneService {
  constructor({ Milestone }) {
    this.Milestone = Milestone;
  }

  add = ({ title, dueDate, description }) =>
    this.Milestone.create({ title, dueDate, description });

  findAll = async () => this.Milestone.findAll();

  update = async ({ num, payload }) =>
    this.Milestone.update(payload, { where: { num } });

  remove = async ({ num }) => this.Milestone.destroy({ where: { num } });
}

module.exports = new MilestoneService({ Milestone });
