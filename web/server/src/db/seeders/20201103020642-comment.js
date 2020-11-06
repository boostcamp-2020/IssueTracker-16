'use strict';

module.exports = {
  up: async queryInterface =>
    queryInterface.bulkInsert('comments', [
      {
        content: '레이블 전체 목록을 볼 수 있어야 한다\n2줄까지 보입니다.',
        issue_num: 1,
        user_num: 1,
        is_deleted: false,
        created_at: new Date(),
        updated_at: new Date(),
      },
      {
        content: '첫 번째 코멘트',
        issue_num: 2,
        user_num: 1,
        is_deleted: false,
        created_at: new Date(),
        updated_at: new Date(),
      },
      {
        content: '첫 번째 코멘트',
        issue_num: 3,
        user_num: 1,
        is_deleted: false,
        created_at: new Date(),
        updated_at: new Date(),
      },
      {
        content: '첫 번째 코멘트',
        issue_num: 4,
        user_num: 2,
        is_deleted: false,
        created_at: new Date(),
        updated_at: new Date(),
      },
      {
        content: '첫 번째 코멘트',
        issue_num: 5,
        user_num: 2,
        is_deleted: false,
        created_at: new Date(),
        updated_at: new Date(),
      },
      {
        content: '첫 번째 코멘트',
        issue_num: 6,
        user_num: 2,
        is_deleted: false,
        created_at: new Date(),
        updated_at: new Date(),
      },
    ]),
  down: async queryInterface => queryInterface.bulkDelete('comments'),
};
