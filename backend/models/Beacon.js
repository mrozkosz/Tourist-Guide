module.exports = (sequelize, Sequelize) => {
    const Beacon = sequelize.define('Beacon', {
        id: {
            type: Sequelize.INTEGER,
            allowNull: false,
            autoIncrement: true,
            primaryKey: true
        },
        uuid: {
            foreignKey: true,
            type: Sequelize.UUID
        },
        pleaceId: {
            foreignKey: true,
            type: Sequelize.INTEGER,
            references: {
                model: 'pleaces',
                key: 'id'
            }
        }
    });

    Beacon.associate = (db) => {
        Beacon.belongsTo(db.Pleace, {
            as: 'pleaces',
            foreignKey: 'pleaceId'
        });
    };

    return Beacon;
};
