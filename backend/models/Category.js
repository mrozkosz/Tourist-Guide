module.exports = (sequelize, Sequelize) => {
    const Category = sequelize.define('Category', {
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

    Category.associate = (db) => {
        Category.belongsToMany(db.Pleace, {
            as: 'pleace',
            through: 'PleaceCategory',
            foreignKey: 'categorieId',
            otherKey: 'pleaceId'
        });
    };

    return Category;
};
