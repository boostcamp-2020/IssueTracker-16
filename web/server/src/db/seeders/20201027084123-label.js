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
    return queryInterface.bulkInsert('labels', [
      {
        name: 'bug',
        color: 'ff0066',
        description: '버그 수정',
      },
      {
        name: 'documentation',
        color: '0000ff',
        description: '문서 작성',
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
    return queryInterface.bulkDelete('labels');
  },
};
