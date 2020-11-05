'use strict';

module.exports = {
  up: async queryInterface =>
    queryInterface.bulkInsert('users', [
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
    ]),
  down: async queryInterface => queryInterface.bulkDelete('users'),
};
