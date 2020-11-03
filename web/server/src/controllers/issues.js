const issueService = require('../services/issues');
const { NO_CONTENTS } = require('../common/errorHandler');

class IssueController {
  constructor({ issueService }) {
    this.issueService = issueService;
  }

  getAll = async (req, res) => {};

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
