'use strict';

module.exports = {
  up: async queryInterface =>
    queryInterface.bulkInsert('issues', [
      {
        title: 'week 1 - 첫 번째 이슈',
        user_num: 1,
        milestone_num: 1,
        is_closed: true,
        created_at: new Date(),
        updated_at: new Date(),
      },
      {
        title: 'week 1 - 두 번째 이슈',
        user_num: 1,
        milestone_num: 1,
        is_closed: false,
        created_at: new Date(),
        updated_at: new Date(),
      },
      {
        title: 'week 1 - 세 번째 이슈',
        user_num: 2,
        milestone_num: 1,
        is_closed: false,
        created_at: new Date(),
        updated_at: new Date(),
      },
      {
        title: 'week 2 - 첫 번째 이슈',
        user_num: 1,
        milestone_num: 2,
        is_closed: true,
        created_at: new Date(),
        updated_at: new Date(),
      },
      {
        title: 'week 2 - 두 번째 이슈',
        user_num: 2,
        milestone_num: 2,
        is_closed: true,
        created_at: new Date(),
        updated_at: new Date(),
      },
      {
        title: 'week 2 - 세 번째 이슈',
        user_num: 2,
        milestone_num: 2,
        is_closed: false,
        created_at: new Date(),
        updated_at: new Date(),
      },
    ]),
  down: async queryInterface => queryInterface.bulkDelete('issues'),
};
