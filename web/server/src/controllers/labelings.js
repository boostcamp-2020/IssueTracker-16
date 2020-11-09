const labelingService = require('../services/labelings');

const labelingController = {
  add: async (req, res) => {
    const { issueNum, labelNum } = req.body;
    await labelingService.add({ issueNum, labelNum });
    res.status(200).json({ success: true });
  },

  delete: async (req, res) => {
    const { issueNum, labelNum } = req.params;
    await labelingService.delete({ issueNum, labelNum });
    res.status(200).json({ success: true });
  },
};

module.exports = labelingController;
