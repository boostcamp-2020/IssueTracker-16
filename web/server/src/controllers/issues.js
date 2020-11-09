const issueService = require('../services/issues');
const commentService = require('../services/comments');
const { NO_CONTENTS, BAD_REQUEST } = require('../common/errorHandler');

const issueController = {
  getAll: async (req, res) => {
    const issues = await issueService.findAll();
    res.status(200).json(issues);
  },

  getOne: async (req, res) => {
    const { num } = req.params;
    const issue = await issueService.findOneByNum({ num });
    if (!issue) {
      throw new Error(NO_CONTENTS);
    }
    res.status(200).json(issue);
  },

  add: async (req, res) => {
    const { title, content, assignees, labels, milestoneNum } = req.body;
    const userNum = 1; // 인증 정보에서 userNum 값 빼오기
    if (!content) {
      throw new Error(BAD_REQUEST);
    }
    const issue = await issueService.add({ title, userNum, milestoneNum });
    await commentService.add({ content, userNum, issueNum: issue.num });
    // assignees 피봇 테이블에 등록
    // labeling 피봇 테이블에 등록
    res.status(200).json({ success: true });
  },

  update: async (req, res) => {
    const {
      params: { num },
      body: payload,
    } = req;
    const [updated] = await issueService.update({ num, payload });
    if (!updated) {
      throw new Error(NO_CONTENTS);
    }
    res.status(200).json({ success: true });
  },
};

module.exports = issueController;
