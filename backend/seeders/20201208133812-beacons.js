'use strict';

module.exports = {
    up: async (queryInterface, Sequelize) => {
        await queryInterface.bulkInsert(
            'Beacons',
            [
                {
                    uuid: 'cb9b8d9c1d21317d13d1827a85241907',
                    pleaceId: '1'
                }
            ],
            {}
        );
    },

    down: (queryInterface, Sequelize) => {}
};
