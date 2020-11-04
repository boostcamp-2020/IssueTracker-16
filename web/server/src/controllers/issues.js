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
};

module.exports = issueController;
