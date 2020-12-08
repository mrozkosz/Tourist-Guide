module.exports = (sequelize, Sequelize) => {
    const Favorite = sequelize.define('Favorite', {
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

        userId: {
            type: Sequelize.STRING,
            allowNull: false
        },

        isFavorite: {
            allowNull: false,
            type: Sequelize.BOOLEAN,
            defaultValue: 0
        }
    });
    Favorite.associate = (db) => {
        Favorite.belongsTo(db.Pleace, {
            as: 'pleace',
            foreignKey: 'pleaceId'
        });
    };

    return Favorite;
};
