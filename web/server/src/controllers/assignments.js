const assignmentService = require('../services/assignments');

const assignmentController = {
  add: async (req, res) => {
    const { issueNum, userNum } = req.body;
    await assignmentService.add({ issueNum, userNum });
    res.status(200).json({ success: true });
  },

  delete: async (req, res) => {
    const { issueNum, userNum } = req.params;
    await assignmentService.delete({ issueNum, userNum });
    res.status(200).json({ success: true });
  },
};

module.exports = assignmentController;
