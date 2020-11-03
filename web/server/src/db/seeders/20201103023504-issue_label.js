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
    return queryInterface.bulkInsert('issues_labels', [
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
    ]);
  },

  down: async (queryInterface, Sequelize) => {
    /**
     * Add commands to revert seed here.
     *
     * Example:
     * await queryInterface.bulkDelete('People', null, {});
     */
    return queryInterface.bulkDelete('issues_labels');
  },
};
