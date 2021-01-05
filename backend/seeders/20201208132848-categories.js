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

    down: (queryInterface, Sequelize) => {}
};
