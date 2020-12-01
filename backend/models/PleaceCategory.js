module.exports = (sequelize, Sequelize) => {
    const PleaceCategory = sequelize.define('PleaceCategory', {
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
        }
    });

    PleaceCategory.associate = (db) => {
        PleaceCategory.belongsTo(db.Pleace, {
            as: 'pleace',
            foreignKey: 'pleaceId'
        });
    };

    return PleaceCategory;
};
