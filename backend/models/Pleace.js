module.exports = (sequelize, Sequelize) => {
    const Pleace = sequelize.define('Pleace', {
        id: {
            type: Sequelize.INTEGER,
            allowNull: false,
            autoIncrement: true,
            primaryKey: true
        },

        coverImage: {
            type: Sequelize.STRING,
            allowNull: false
        },

        location: {
            type: Sequelize.STRING,
            allowNull: false
        },

        name: {
            type: Sequelize.STRING,
            allowNull: false
        },

        description: {
            type: Sequelize.STRING,
            allowNull: false
        },

        lat: {
            type: Sequelize.STRING,
            allowNull: false
        },

        long: {
            type: Sequelize.STRING,
            allowNull: false
        }
    });

    Pleace.associate = (db) => {
        Pleace.hasMany(db.Photo, {
            as: 'photos',
            foreignKey: 'pleaceId',
            onDelete: 'cascade'
        });

        Pleace.hasMany(db.Track, {
            as: 'tracks',
            foreignKey: 'pleaceId',
            onDelete: 'cascade'
        });
    };
    return Pleace;
};
