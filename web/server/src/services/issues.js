const Op = require('Sequelize').Op;
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
  findAll: async ({ isClosed, author, milestone, label, assignee }) => {
    const issues = await Issue.findAll({
      attributes: ['num', 'title', 'createdAt', 'isClosed'],
      where: { isClosed },
      order: [['num', 'DESC']],
      include: [
        {
          model: User,
          as: 'author',
          attributes: ['num', 'id'],
          where: author && { id: author },
        },
        {
          model: Milestone,
          attributes: ['num', 'title'],
          where: milestone && { title: milestone },
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
          where: label && {
            name: {
              [Op.or]: [label],
            },
          },
        },
        {
          model: User,
          as: 'assignees',
          attributes: ['num', 'id', 'imageUrl'],
          where: assignee && {
            id: {
              [Op.or]: [assignee],
            },
          },
        },
      ],
    });
    return issues.map(issue => {
      issue.dataValues.comment = issue.dataValues.comments[0];
      delete issue.dataValues.comments;
      return issue;
    });
  },

  count: async ({ author, milestone, label, assignee }) =>
    Issue.count({
      distinct: true,
      include: [
        {
          model: User,
          as: 'author',
          where: author && { id: author },
        },
        {
          model: Milestone,
          where: milestone && { title: milestone },
        },
        {
          model: Label,
          as: 'labels',
          where: label && {
            name: {
              [Op.or]: [label],
            },
          },
        },
        {
          model: User,
          as: 'assignees',
          where: assignee && {
            id: {
              [Op.or]: [assignee],
            },
          },
        },
      ],
    }),

  findOneByNum: async ({ num }) =>
    Issue.findOne({
      attributes: ['num', 'title', 'createdAt', 'isClosed'],
      where: { num },
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
          attributes: ['num', 'id', 'imageUrl'],
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
            attributes: ['num', 'id', 'imageUrl'],
          },
        },
      ],
    }),

  add: async ({ title, userNum, milestoneNum }) =>
    Issue.create({ title, userNum, milestoneNum }),

  update: async ({ num, payload }) => Issue.update(payload, { where: { num } }),

  delete: async ({ num }) => Issue.destroy({ where: { num } }),
};

module.exports = issueService;
