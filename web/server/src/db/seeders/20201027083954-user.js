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
    return queryInterface.bulkInsert('users', [
      {
        id: 'user01',
        password: 'user01',
        name: 'user01',
      },
      {
        id: 'user02',
        password: 'user02',
        name: 'user02',
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
    return queryInterface.bulkDelete('users');
  },
};
