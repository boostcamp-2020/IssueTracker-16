const { sequelize, Comment, Issue, User } = require('../db/models');

const commentService = {
  add: async ({ content, userNum, issueNum }) =>
    Comment.create({ content, user_num: userNum, issue_num: issueNum }),
  update: async (req, res) => {},

  delete: async (req, res) => {},
};

module.exports = commentService;
