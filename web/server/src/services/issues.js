const { Issue, Label, Milestone, User } = require('../db/models');

class IssueService {
  constructor({ Issue, Label, Milestone, User }) {
    this.Issue = Issue;
    this.Label = Label;
    this.Milestone = Milestone;
    this.User = User;
  }

  findAll = async () => {};

  findOne = async () => {};
}

module.exports = new IssueService({ Issue, Label, Milestone, User });
