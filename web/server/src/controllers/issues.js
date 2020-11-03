const issueService = require('../services/issues');

class IssueController {
  constructor({ issueService }) {
    this.issueService = issueService;
  }

  getAll = async (req, res) => {};

  getOne = async (req, res) => {};
}

module.exports = new IssueController({ issueService });
