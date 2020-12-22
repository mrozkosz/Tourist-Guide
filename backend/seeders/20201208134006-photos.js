module.exports = {
    up: async (queryInterface, Sequelize) => {
        await queryInterface.bulkInsert(
            'Photos',
            [
                {
                    pleaceId: '1',
                    url: '',
                    description: ''
                }
            ],
            {}
        );
    },

    down: (queryInterface, Sequelize) => {}
};
