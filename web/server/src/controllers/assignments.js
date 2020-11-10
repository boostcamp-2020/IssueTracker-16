const assignmentService = require('../services/assignments');
const { VALIDATION_ERROR } = require('../common/errorHandler');
const { CREATED, OK } = require('../common/status');

const assignmentController = {
  add: async (req, res) => {
    const { issueNum, userNum } = req.body;
    const result = await assignmentService.add({ issueNum, userNum });
    if (!result) {
      throw new Error(VALIDATION_ERROR);
    }
    res.status(CREATED).json({ success: true });
  },

  delete: async (req, res) => {
    const { issueNum, userNum } = req.params;
    await assignmentService.delete({ issueNum, userNum });
    res.status(OK).json({ success: true });
  },
};

module.exports = assignmentController;
