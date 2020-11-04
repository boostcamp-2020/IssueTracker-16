const issueService = require('../services/issues');

class IssueController {
  constructor({ issueService }) {
    this.issueService = issueService;
  }

  getAll = async (req, res) => {
    const issues = await this.issueService.findAll();
    res.status(200).json(issues);
  };

  getOne = async (req, res) => {};
}

module.exports = new IssueController({ issueService });
