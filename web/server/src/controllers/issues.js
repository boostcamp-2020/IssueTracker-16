const issueService = require('../services/issues');
const { NO_CONTENTS } = require('../common/errorHandler');

class IssueController {
  constructor({ issueService }) {
    this.issueService = issueService;
  }

  getAll = async (req, res) => {
    const issues = await this.issueService.findAll();
    res.status(200).json(issues);
  };

  getOne = async (req, res) => {
    const { num } = req.params;
    const issue = await this.issueService.findOneByNum({ num });
    if (!issue) {
      throw new Error(NO_CONTENTS);
    }
    res.status(200).json(issue);
  };
}

module.exports = new IssueController({ issueService });
