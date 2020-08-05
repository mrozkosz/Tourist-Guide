module.exports = (sequelize, Sequelize) => {
    const Pleace = sequelize.define('Pleace', {
        id: {
            type: Sequelize.INTEGER,
            allowNull: false,
            autoIncrement: true,
            primaryKey: true
        },

        name: {
            type: Sequelize.STRING,
            allowNull: false
        }
    });

    Pleace.associate = (db) => {
        Pleace.hasMany(db.Photo, {
            as: 'photos',
            foreignKey: 'pleaceId'
        });
    };
    return Pleace;
};
