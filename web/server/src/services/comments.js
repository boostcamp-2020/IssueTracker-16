const { Comment } = require('../db/models');

const commentService = {
  add: async ({ content, userNum, issueNum }) =>
    Comment.create({ content, userNum, issueNum }),
  update: async ({ num, content }) =>
    Comment.update({ content }, { where: { num } }),

  delete: async (req, res) => {},
};

module.exports = commentService;
