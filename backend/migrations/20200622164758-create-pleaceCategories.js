'use strict';
module.exports = {
    up: (queryInterface, Sequelize) => {
        return queryInterface.createTable('PleaceCategories', {
            id: {
                type: Sequelize.INTEGER,
                allowNull: false,
                autoIncrement: true,
                primaryKey: true
            },
            categorieId: {
                foreignKey: true,
                type: Sequelize.INTEGER,
                references: {
                    model: 'Categories',
                    key: 'id'
                }
            },
            pleaceId: {
                foreignKey: true,
                type: Sequelize.INTEGER,
                onDelete: 'CASCADE',
                references: {
                    model: 'Pleaces',
                    key: 'id'
                }
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
        return queryInterface.dropTable('PleaceCategories');
    }
};
