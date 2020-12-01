module.exports = (sequelize, Sequelize) => {
    const Track = sequelize.define(
        'Track',
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

            title: {
                type: Sequelize.STRING,
                allowNull: false
            },

            url: {
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
    Track.associate = (db) => {
        Track.belongsTo(db.Pleace, {
            foreignKey: 'id'
        });
    };

    return Track;
};
