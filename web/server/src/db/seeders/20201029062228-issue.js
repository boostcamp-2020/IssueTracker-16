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
    return queryInterface.bulkInsert('issues', [
      {
        title: '첫 번째 이슈',
        user_num: 1,
        milestone_num: 1,
        is_closed: false,
        is_deleted: false,
        created_at: new Date(),
        updated_at: new Date(),
      },
      {
        title: '두 번째 이슈',
        user_num: 1,
        milestone_num: 1,
        is_closed: false,
        is_deleted: false,
        created_at: new Date(),
        updated_at: new Date(),
      },
      {
        title: '세 번째 이슈',
        user_num: 1,
        milestone_num: 1,
        is_closed: true,
        is_deleted: false,
        created_at: new Date(),
        updated_at: new Date(),
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
    return queryInterface.bulkDelete('issues');
  },
};
