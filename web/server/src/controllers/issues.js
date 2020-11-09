const issueService = require('../services/issues');
const { NO_CONTENTS } = require('../common/errorHandler');

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
