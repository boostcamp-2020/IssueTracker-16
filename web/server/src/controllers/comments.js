const commentService = require('../services/comments');
const { NO_CONTENTS } = require('../common/errorHandler');

const commentController = {
  add: async (req, res) => {
    const { content, issueNum } = req.body;
    const userNum = 1; // 인증 정보에서 userNum 값 빼오기
    await commentService.add({ content, issueNum, userNum });
    res.status(200).json({ success: true });
  },

  update: async (req, res) => {
    const {
      params: { num },
      body: { content },
    } = req;
    const [updated] = await commentService.update({ num, content });
    if (!updated) {
      throw new Error(NO_CONTENTS);
    }
    res.status(200).json({ success: true });
  },
};

module.exports = commentController;
