const {
  sequelize,
  Issue,
  Label,
  Milestone,
  User,
  Comment,
} = require('../db/models');
const { countOpenedIssues, countClosedIssues } = require('../common/query');

class IssueService {
  constructor({ sequelize, Issue, Label, Milestone, User, Comment }) {
    this.sequelize = sequelize;
    this.Issue = Issue;
    this.Label = Label;
    this.Milestone = Milestone;
    this.User = User;
    this.Comment = Comment;
  }

  findAll = async () => {};

  findOneByNum = async ({ num }) =>
    this.Issue.findOne({
      attributes: ['num', 'title', 'createdAt', 'isClosed', 'isDeleted'],
      where: { num, isDeleted: false },
      include: [
        {
          model: this.User,
          as: 'author',
          attributes: ['num', 'id'],
        },
        {
          model: this.User,
          as: 'assignees',
          required: false,
          attributes: ['num', 'id'],
        },
        {
          model: this.Label,
          as: 'labels',
          attributes: ['num', 'name', 'color'],
        },
        {
          model: this.Milestone,
          as: 'milestone',
          required: false,
          attributes: [
            'num',
            'title',
            [this.sequelize.literal(countOpenedIssues), 'openedIssues'],
            [this.sequelize.literal(countClosedIssues), 'closedIssues'],
          ],
        },
        {
          model: this.Comment,
          as: 'comments',
          attributes: ['num', 'content', 'createdAt'],
          where: { isDeleted: false },
          include: {
            model: this.User,
            as: 'writer',
            attributes: ['num', 'id'],
          },
        },
      ],
    });
}

module.exports = new IssueService({
  sequelize,
  Issue,
  Label,
  Milestone,
  User,
  Comment,
});
