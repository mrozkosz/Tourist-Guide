module.exports = (sequelize, Sequelize) => {
    const UserRole = sequelize.define('UserRole', {
        id: {
            type: Sequelize.INTEGER,
            allowNull: false,
            autoIncrement: true,
            primaryKey: true
        },
        roleId: {
            foreignKey: true,
            type: Sequelize.INTEGER,
            references: {
                model: 'roles',
                key: 'id'
            }
        },
        userId: {
            foreignKey: true,
            type: Sequelize.INTEGER,
            onDelete: 'CASCADE',
            references: {
                model: 'users',
                key: 'id'
            }
        }
    });

    return UserRole;
};
