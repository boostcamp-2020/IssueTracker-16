'use strict';

module.exports = {
  up: async queryInterface =>
    queryInterface.bulkInsert('milestones', [
      {
        title: 'week 1',
        due_date: new Date(2020, 10, 30),
        description: '첫 번째 주차 입니다.',
        is_closed: false,
      },
      {
        title: 'week 2',
        due_date: new Date(2020, 11, 6),
        description: '두 번째 주차 입니다.',
        is_closed: false,
      },
      {
        title: 'week 3',
        description: '세 번째 주차 입니다.',
        is_closed: false,
      },
    ]),
  down: async queryInterface => queryInterface.bulkDelete('milestones'),
};
