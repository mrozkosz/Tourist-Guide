'use strict';

module.exports = {
    up: async (queryInterface, Sequelize) => {
        await queryInterface.bulkInsert(
            'Categories',
            [
                {
                    name: 'Miasta'
                },
                {
                    name: 'Zabytki'
                },
                {
                    name: 'Zbiorniki wodne'
                },
                {
                    name: 'Muzea'
                }
            ],
            {}
        );
    },

    down: (queryInterface, Sequelize) => {
        /*
      Add reverting commands here.
      Return a promise to correctly handle asynchronicity.

      Example:
      return queryInterface.bulkDelete('People', null, {});
    */
    }
};
