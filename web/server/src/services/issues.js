const {
  sequelize,
  Issue,
  Label,
  Milestone,
  User,
  Comment,
} = require('../db/models');
const { countOpenedIssues, countClosedIssues } = require('../common/query');

const issueService = {
  findAll: async ({ isClosed }) => {
    const issues = await Issue.findAll({
      attributes: ['num', 'title', 'createdAt', 'isClosed'],
      where: {
        isDeleted: false,
        isClosed,
      },
      order: [['num', 'DESC']],
      include: [
        {
          model: User,
          as: 'author',
          attributes: ['num', 'id'],
        },
        {
          model: Milestone,
          attributes: ['num', 'title'],
        },
        {
          model: Comment,
          as: 'comments',
          attributes: ['content'],
          limit: 1,
        },
        {
          model: Label,
          as: 'labels',
          attributes: ['num', 'name', 'color'],
        },
        {
          model: User,
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
  },

  count: async () => Issue.count(),

  findOneByNum: async ({ num }) =>
    Issue.findOne({
      attributes: ['num', 'title', 'createdAt', 'isClosed', 'isDeleted'],
      where: { num, isDeleted: false },
      include: [
        {
          model: User,
          as: 'author',
          attributes: ['num', 'id'],
        },
        {
          model: User,
          as: 'assignees',
          required: false,
          attributes: ['num', 'id'],
        },
        {
          model: Label,
          as: 'labels',
          attributes: ['num', 'name', 'color'],
        },
        {
          model: Milestone,
          required: false,
          attributes: [
            'num',
            'title',
            [sequelize.literal(countOpenedIssues), 'openedIssues'],
            [sequelize.literal(countClosedIssues), 'closedIssues'],
          ],
        },
        {
          model: Comment,
          as: 'comments',
          attributes: ['num', 'content', 'createdAt'],
          where: { isDeleted: false },
          include: {
            model: User,
            as: 'writer',
            attributes: ['num', 'id'],
          },
        },
      ],
    }),

  add: async ({ title, userNum, milestoneNum }) =>
    Issue.create({ title, userNum, milestoneNum }),

  update: async ({ num, payload }) => Issue.update(payload, { where: { num } }),
};

module.exports = issueService;
