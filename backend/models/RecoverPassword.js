module.exports = (sequelize, Sequelize) => {
    const RecoverPassword = sequelize.define('RecoverPassword', {
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
        hash: {
            type: Sequelize.STRING,
            allowNull: false
        },
        expireIn: {
            allowNull: false,
            type: Sequelize.DATE
        }
    });

    RecoverPassword.associate = function (db) {
        RecoverPassword.belongsTo(db.User, {
            as: 'user',
            foreignKey: 'userId'
        });
    };

    return RecoverPassword;
};
