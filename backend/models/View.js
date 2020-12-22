module.exports = (sequelize, Sequelize) => {
    const View = sequelize.define('View', {
        id: {
            allowNull: false,
            autoIncrement: true,
            primaryKey: true,
            type: Sequelize.INTEGER
        },
        userId: {
            foreignKey: true,
            type: Sequelize.INTEGER,
            onDelete: 'CASCADE',
            references: {
                model: 'Users',
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
        },
        views: {
            allowNull: false,
            type: Sequelize.INTEGER,
            defaultValue: 0
        },
        ip: {
            allowNull: false,
            type: Sequelize.INET,
            defaultValue: 0
        }
    });

    return View;
};
