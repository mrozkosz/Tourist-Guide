module.exports = (sequelize, Sequelize) => {
    const VacationDay = sequelize.define('VacationDay', {
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
        }
    });

    VacationDay.associate = (db) => {
        VacationDay.belongsToMany(db.Contract, {
            as: 'contracts',
            through: 'VacationDays',
            foreignKey: 'contractId',
            otherKey: 'userId'
        });
    };

    return VacationDay;
};
