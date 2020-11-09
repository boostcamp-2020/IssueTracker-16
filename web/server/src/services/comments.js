const { Comment } = require('../db/models');

const commentService = {
  add: async ({ content, userNum, issueNum }) =>
    Comment.create({ content, user_num: userNum, issue_num: issueNum }),
  update: async ({ num, content }) =>
    Comment.update({ content }, { where: { num } }),

  delete: async (req, res) => {},
};

module.exports = commentService;
