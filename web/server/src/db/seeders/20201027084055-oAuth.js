'use strict';

module.exports = {
  up: async queryInterface =>
    queryInterface.bulkInsert('oauths', [
      {
        name: 'gitHub',
      },
      {
        name: 'apple',
      },
    ]),
  down: async queryInterface => queryInterface.bulkDelete('oauths'),
};
