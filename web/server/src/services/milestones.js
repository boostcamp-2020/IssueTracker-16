const { Milestone } = require('../db/models');

class MilestoneService {
  constructor({ Milestone }) {
    this.Milestone = Milestone;
  }

  add = async () => this.Milestone.create();

  findAll = async () => this.Milestone.findAll();

  update = async () => this.Milestone.update();

  remove = async ({ num }) => this.Milestone.destroy({ where: { num } });
}

module.exports = new MilestoneService({ Milestone });
