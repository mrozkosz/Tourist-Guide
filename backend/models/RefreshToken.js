module.exports = (sequelize, Sequelize) => {
    const RefreshToken = sequelize.define('RefreshToken', {
        id: {
            type: Sequelize.INTEGER,
            autoIncrement: true,
            primaryKey: true
        },
        userId: {
            type: Sequelize.INTEGER,
            onDelete: 'CASCADE',
            references: {
                model: 'users',
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

    RefreshToken.associate = function (db) {
        RefreshToken.belongsTo(db.User, {
            as: 'user',
            foreignKey: 'userId'
        });
    };

    return RefreshToken;
};
