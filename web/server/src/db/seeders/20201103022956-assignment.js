'use strict';

module.exports = {
  up: async queryInterface =>
    queryInterface.bulkInsert('assignments', [
      {
        issue_num: 1,
        user_num: 1,
      },
      {
        issue_num: 2,
        user_num: 1,
      },
      {
        issue_num: 2,
        user_num: 2,
      },
      {
        issue_num: 4,
        user_num: 2,
      },
    ]),
  down: async queryInterface => queryInterface.bulkDelete('assignments'),
};
