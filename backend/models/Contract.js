module.exports = (sequelize, Sequelize) => {
    const Contract = sequelize.define('Contract', {
        id: {
            type: Sequelize.INTEGER,
            autoIncrement: true,
            primaryKey: true
        },
        userId: {
            type: Sequelize.INTEGER,
            references: {
                model: 'Users',
                key: 'id'
            }
        },
        duration: {
            type: Sequelize.INTEGER,
            allowNull: false
        },
        startDay: {
            type: Sequelize.DATEONLY,
            allowNull: false
        },
        stopDay: {
            type: Sequelize.DATEONLY,
            allowNull: true
        },
        freeDays: {
            type: Sequelize.INTEGER,
            allowNull: false
        }
    });

    Contract.associate = (db) => {
        Contract.belongsTo(db.User);
        Contract.hasMany(db.VacationDay, {
            as: 'vacationDays'
        });
    };

    return Contract;
};
