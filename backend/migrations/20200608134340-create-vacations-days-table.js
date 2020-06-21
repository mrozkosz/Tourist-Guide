'use strict';

module.exports = {
    up: (queryInterface, Sequelize) => {
        return queryInterface.createTable('VacationDays', {
            id: {
                type: Sequelize.INTEGER,
                autoIncrement: true,
                primaryKey: true
            },
            userId: {
                type: Sequelize.INTEGER,
                onDelete: 'CASCADE',
                references: {
                    model: 'Users',
                    key: 'id'
                }
            },
            contractId: {
                type: Sequelize.INTEGER,
                onDelete: 'CASCADE',
                references: {
                    model: 'Contracts',
                    key: 'id'
                }
            },
            startDay: {
                type: Sequelize.DATEONLY,
                allowNull: false
            },
            stopDay: {
                type: Sequelize.DATEONLY,
                allowNull: true
            },
            days: {
                type: Sequelize.INTEGER,
                allowNull: false
            },
            isApproved: {
                type: Sequelize.BOOLEAN,
                allowNull: false,
                defaultValue: 0
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
        return queryInterface.dropTable('VacationDays');
    }
};
