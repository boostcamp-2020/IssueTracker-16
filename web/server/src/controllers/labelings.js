const labelingService = require('../services/labelings');
const { VALIDATION_ERROR } = require('../common/errorHandler');
const { CREATED, OK } = require('../common/status');

const labelingController = {
  add: async (req, res) => {
    const { issueNum, labelNum } = req.body;
    const result = await labelingService.add({ issueNum, labelNum });
    if (!result) {
      throw new Error(VALIDATION_ERROR);
    }
    res.status(CREATED).json({ success: true });
  },

  delete: async (req, res) => {
    const { issueNum, labelNum } = req.params;
    await labelingService.delete({ issueNum, labelNum });
    res.status(OK).json({ success: true });
  },
};

module.exports = labelingController;
