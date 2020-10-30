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
        name: 'feature',
        color: 'c4dafa',
        description: '기능에 대한 레이블입니다.',
      },
      {
        name: 'bug',
        color: 'f57f7d',
        description: '수정할 버그에 대한 레이블입니다.',
      },
      {
        name: 'good',
        color: 'f5bd39',
        description: '그냥 멋진 레이블입니다.',
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
