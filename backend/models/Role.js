module.exports = (sequelize, Sequelize) => {
    const Role = sequelize.define('Role', {
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

    Role.associate = function (db) {
        Role.belongsToMany(db.User, {
            as: 'users',
            through: 'UserRoles',
            foreignKey: 'roleId',
            otherKey: 'userId'
        });
    };

    Role.ADMIN = 'admin';
    Role.USER = 'user';

    return Role;
};
