const { Issue, User } = require('../db/models');
const { NO_CONTENTS } = require('../common/errorHandler');

const assignmentService = {
  add: async ({ issueNum, userNum }) => {
    const issue = await Issue.findByPk(issueNum);
    const user = await User.findByPk(userNum);
    if (!issue || !user) {
      throw new Error(NO_CONTENTS);
    }
    return issue.addAssignees(user);
  },

  delete: async ({ issueNum, userNum }) => {
    const issue = await Issue.findOne({
      where: { num: issueNum },
      include: [
        {
          model: User,
          as: 'assignees',
          where: { num: userNum },
        },
      ],
    });
    if (!issue) {
      throw new Error(NO_CONTENTS);
    }
    return issue.removeAssignees(userNum);
  },
};

module.exports = assignmentService;
