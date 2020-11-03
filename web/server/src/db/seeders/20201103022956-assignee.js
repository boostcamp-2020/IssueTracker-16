'use strict';

module.exports = {
  up: async (queryInterface, Sequelize) => {
    /**
     * Add seed commands here.
     *
     * Example:
     * await queryInterface.bulkInsert('People', [{
     *   name: 'John Doe',
     *   isBetaMember: false
     * }], {});
     */
    return queryInterface.bulkInsert('assignees', [
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
    ]);
  },

  down: async (queryInterface, Sequelize) => {
    /**
     * Add commands to revert seed here.
     *
     * Example:
     * await queryInterface.bulkDelete('People', null, {});
     */
    return queryInterface.bulkDelete('assignees');
  },
};
