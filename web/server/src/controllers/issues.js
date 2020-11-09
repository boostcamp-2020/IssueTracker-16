const issueService = require('../services/issues');
const { NO_CONTENTS } = require('../common/errorHandler');

const issueController = {
  getAll: async (req, res) => {
    const isClosed = req.query.isClosed === 'true' ? true : false;
    const [issues, total] = await Promise.all([
      issueService.findAll({ isClosed }),
      issueService.count(),
    ]);
    const count = issues.length;
    const [open, closed] = isClosed
      ? [total - count, count]
      : [count, total - count];
    res.status(200).json({ open, closed, issues });
  },

  getOne: async (req, res) => {
    const { num } = req.params;
    const issue = await issueService.findOneByNum({ num });
    if (!issue) {
      throw new Error(NO_CONTENTS);
    }
    res.status(200).json(issue);
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
