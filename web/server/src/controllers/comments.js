const commentService = require('../services/comments');

const commentController = {
  add: async (req, res) => {
    const { content, issueNum } = req.body;
    const userNum = 1; // 인증 정보에서 userNum 값 빼오기
    await commentService.add({ content, issueNum, userNum });
    res.status(200).json({ success: true });
  },

  update: async (req, res) => {},

  delete: async (req, res) => {},
};

module.exports = commentController;
