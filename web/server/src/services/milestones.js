const { Milestone } = require('../db/models');

class MilestoneService {
  constructor({ Milestone }) {
    this.Milestone = Milestone;
  }

  add = ({ title, dueDate, description }) =>
    this.Milestone.create({ title, dueDate, description });

  findAll = async () => this.Milestone.findAll();

  update = async () => this.Milestone.update();

  remove = async () => this.Milestone.destroy();
}

module.exports = new MilestoneService({ Milestone });
