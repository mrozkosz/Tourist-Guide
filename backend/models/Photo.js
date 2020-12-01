module.exports = (sequelize, Sequelize) => {
    const Photo = sequelize.define(
        'Photo',
        {
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

            url: {
                type: Sequelize.STRING,
                allowNull: false
            },

            description: {
                type: Sequelize.STRING,
                allowNull: false
            }
        },
        {
            defaultScope: {
                attributes: { exclude: ['pleaceId'] }
            }
        }
    );
    Photo.associate = (db) => {
        Photo.belongsTo(db.Pleace, {
            foreignKey: 'id'
        });
    };

    return Photo;
};
