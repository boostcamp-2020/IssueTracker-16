const { Issue, Label, Milestone, User, Comment } = require('../db/models');

class IssueService {
  constructor({ Issue, Label, Milestone, User, Comment }) {
    this.Issue = Issue;
    this.Label = Label;
    this.Milestone = Milestone;
    this.User = User;
    this.Comment = Comment;
  }

  findAll = async () => {
    const issues = await this.Issue.findAll({
      attributes: ['num', 'title', 'createdAt', 'isClosed'],
      where: {
        isDeleted: false,
        isClosed: false,
      },
      include: [
        {
          model: this.User,
          as: 'author',
          attributes: ['num', 'id'],
        },
        {
          model: this.Milestone,
          as: 'milestone',
          attributes: ['num', 'title'],
        },
        {
          model: this.Comment,
          as: 'comments',
          attributes: ['content'],
          limit: 1,
        },
        {
          model: this.Label,
          as: 'labels',
          attributes: ['num', 'name', 'color'],
        },
        {
          model: this.User,
          as: 'assignees',
          attributes: ['num', 'id'],
        },
      ],
    });
    return issues.map(issue => {
      issue.dataValues.comment = issue.dataValues.comments[0];
      delete issue.dataValues.comments;
      return issue;
    });
  };

  findOne = async () => {};
}

module.exports = new IssueService({ Issue, Label, Milestone, User, Comment });
