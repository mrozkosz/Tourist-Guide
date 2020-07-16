'use strict';

module.exports = {
    up: (queryInterface, Sequelize) => {
        return queryInterface.createTable('Pleaces', {
            id: {
                type: Sequelize.INTEGER,
                allowNull: false,
                autoIncrement: true,
                primaryKey: true
            },

            photosId: {
                foreignKey: true,
                type: Sequelize.INTEGER,
                references: {
                    model: 'Photos',
                    key: 'id'
                }
            },

            name: {
                type: Sequelize.STRING,
                allowNull: false
            },

            createdAt: {
                allowNull: false,
                type: Sequelize.DATE,
                defaultValue: Sequelize.literal('NOW()')
            },
            updatedAt: {
                allowNull: false,
                type: Sequelize.DATE,
                defaultValue: Sequelize.literal('NOW()')
            }
        });
    },

    down: (queryInterface, Sequelize) => {
        return queryInterface.dropTable('Pleaces');
    }
};
