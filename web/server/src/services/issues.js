const { Issue, Label, Milestone, User, Comment } = require('../db/models');

class IssueService {
  constructor({ Issue, Label, Milestone, User, Comment }) {
    this.Issue = Issue;
    this.Label = Label;
    this.Milestone = Milestone;
    this.User = User;
    this.Comment = Comment;
  }

  findAll = async () => {};

  findOne = async () => {};
}

module.exports = new IssueService({ Issue, Label, Milestone, User, Comment });
