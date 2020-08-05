'use strict';

module.exports = {
    up: (queryInterface, Sequelize) => {
        return queryInterface.createTable('Photos', {
            id: {
                type: Sequelize.INTEGER,
                allowNull: false,
                autoIncrement: true,
                primaryKey: true
            },

            pleaceId: {
                foreignKey: true,
                type: Sequelize.INTEGER,
                references: {
                    model: 'Pleaces',
                    key: 'id'
                }
            },

            url: {
                type: Sequelize.STRING,
                allowNull: false
            },

            description: {
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
        return queryInterface.dropTable('Photos');
    }
};