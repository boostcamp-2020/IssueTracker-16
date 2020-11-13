const { Issue, Label } = require('../db/models');
const { NOT_FOUND } = require('../common/errorHandler');

const labelingService = {
  add: async ({ issueNum, labelNum }) => {
    const issue = await Issue.findByPk(issueNum);
    const label = await Label.findByPk(labelNum);
    if (!issue || !label) {
      throw new Error(NOT_FOUND);
    }
    return issue.addLabel(label);
  },

  delete: async ({ issueNum, labelNum }) => {
    const issue = await Issue.findOne({
      where: { num: issueNum },
      include: [
        {
          model: Label,
          as: 'labels',
          where: { num: labelNum },
        },
      ],
    });
    if (!issue) {
      throw new Error(NOT_FOUND);
    }
    return issue.removeLabel(labelNum);
  },
};

module.exports = labelingService;
