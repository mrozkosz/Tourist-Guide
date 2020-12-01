module.exports = {
    up: async (queryInterface, Sequelize) => {
        await queryInterface.bulkInsert(
            'Roles',
            [
                {
                    name: 'admin'
                },
                {
                    name: 'user'
                }
            ],
            {}
        );
    },

    down: (queryInterface, Sequelize) => {}
};
