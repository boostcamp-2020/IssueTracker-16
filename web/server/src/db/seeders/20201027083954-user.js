'use strict';

module.exports = {
  up: async queryInterface =>
    queryInterface.bulkInsert('users', [
      {
        id: 'test-seokju2ng',
        password: 'password01',
        name: 'Seokjung Kim',
        image_url: 'https://avatars3.githubusercontent.com/u/43347250?s=40&v=4',
      },
      {
        id: 'test-ahrimy',
        password: 'password02',
        name: 'Ahrim Yang',
        image_url: 'https://avatars1.githubusercontent.com/u/26592306?s=40&v=4',
      },
      {
        id: 'test-skid901',
        password: 'password03',
        name: 'Kyung Deok Si',
        image_url: 'https://avatars2.githubusercontent.com/u/34153657?s=40&v=4',
      },
    ]),
  down: async queryInterface => queryInterface.bulkDelete('users'),
};
