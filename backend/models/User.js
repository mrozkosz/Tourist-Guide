module.exports = (sequelize, Sequelize) => {
    const User = sequelize.define(
        'User',
        {
            id: {
                type: Sequelize.INTEGER,
                allowNull: false,
                autoIncrement: true,
                primaryKey: true
            },
            email: {
                type: Sequelize.STRING,
                unique: true,
                allowNull: false
            },
            password: {
                type: Sequelize.STRING,
                allowNull: false
            },
            firstName: {
                type: Sequelize.STRING,
                allowNull: false
            },
            lastName: {
                type: Sequelize.STRING,
                allowNull: false
            },
            facebookId: {
                type: Sequelize.STRING,
                allowNull: true
            }
        },
        {
            defaultScope: {
                attributes: { exclude: ['password'] }
            }
        }
    );

    User.associate = (db) => {
        User.belongsToMany(db.Role, {
            as: 'roles',
            through: 'UserRoles',
            foreignKey: 'userId',
            otherKey: 'roleId',
            onDelete: 'cascade'
        });

        User.hasMany(db.RecoverPassword, {
            as: 'recoverPasswords'
        });
    };

    const Role = sequelize.import('./Role');

    User.prototype.isEmployee = async function () {
        const roles = await this.getRoles();

        return roles.find((role) => role.name === Role.USER);
    };

    User.prototype.isAdmin = async function () {
        const roles = await this.getRoles();

        return roles.find((role) => role.name === Role.ADMIN);
    };

    return User;
};
