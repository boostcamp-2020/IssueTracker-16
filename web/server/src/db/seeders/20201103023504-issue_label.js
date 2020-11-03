'use strict';

module.exports = {
  up: async queryInterface =>
    queryInterface.bulkInsert('issues_labels', [
      {
        issue_num: 1,
        label_num: 1,
      },
      {
        issue_num: 3,
        label_num: 1,
      },
      {
        issue_num: 3,
        label_num: 2,
      },
      {
        issue_num: 5,
        label_num: 3,
      },
    ]),
  down: async queryInterface => queryInterface.bulkDelete('issues_labels'),
};
