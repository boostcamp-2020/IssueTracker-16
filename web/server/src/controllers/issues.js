const issueService = require('../services/issues');
const commentService = require('../services/comments');
const labelingService = require('../services/labelings');
const assignmentService = require('../services/assignments');
const { NOT_FOUND, BAD_REQUEST } = require('../common/errorHandler');
const { CREATED, OK } = require('../common/status');

const issueController = {
  getAll: async (req, res) => {
    const query = req.query;
    query.isClosed = query.isClosed === 'true' ? true : false;
    const [issues, total] = await Promise.all([
      issueService.findAll(query),
      issueService.count(query),
    ]);
    const count = issues.length;
    const [open, closed] = query.isClosed
      ? [total - count, count]
      : [count, total - count];
    res.status(OK).json({ total, open, closed, issues });
  },

  getOne: async (req, res) => {
    const { num } = req.params;
    const issue = await issueService.findOneByNum({ num });
    if (!issue) {
      throw new Error(NOT_FOUND);
    }
    res.status(OK).json(issue);
  },

  add: async (req, res) => {
    const { title, content, assignees, labels, milestoneNum } = req.body;
    const userNum = 1; // 인증 정보에서 userNum 값 빼오기
    if (!content) {
      throw new Error(BAD_REQUEST);
    }
    const issue = await issueService.add({ title, userNum, milestoneNum });
    await commentService.add({ content, userNum, issueNum: issue.num });
    labels.forEach(labelNum =>
      labelingService.add({ issueNum: issue.num, labelNum }),
    );
    assignees.forEach(userNum =>
      assignmentService.add({ issueNum: issue.num, userNum }),
    );
    res.status(CREATED).json({ success: true });
  },

  update: async (req, res) => {
    const {
      params: { num },
      body: payload,
    } = req;
    const [updated] = await issueService.update({ num, payload });
    if (!updated) {
      throw new Error(NOT_FOUND);
    }
    res.status(OK).json({ success: true });
  },

  delete: async (req, res) => {
    const { num } = req.params;
    const deleted = await issueService.delete({ num });
    if (!deleted) {
      throw new Error(NOT_FOUND);
    }
    res.status(OK).json({ success: true });
  },
};

module.exports = issueController;
