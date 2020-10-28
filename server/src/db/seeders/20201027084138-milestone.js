'use strict';

module.exports = {
  up: async queryInterface => {
    /**
     * Add seed commands here.
     *
     * Example:
     * await queryInterface.bulkInsert('People', [{
     *   name: 'John Doe',
     *   isBetaMember: false
     * }], {});
     */
    return queryInterface.bulkInsert('milestones', [
      {
        title: 'week 1',
        due_date: new Date(),
      },
      {
        title: 'week 2',
        description: '두 번째 주차 입니다.',
      },
    ]);
  },

  down: async queryInterface => {
    /**
     * Add commands to revert seed here.
     *
     * Example:
     * await queryInterface.bulkDelete('People', null, {});
     */
    return queryInterface.bulkDelete('milestones');
  },
};
