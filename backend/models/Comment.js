module.exports = (sequelize, Sequelize) => {
    const Comment = sequelize.define('Comment', {
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
        message: {
            type: Sequelize.STRING
        }
    });
    Comment.associate = (db) => {
        Comment.belongsTo(db.User, {
            as: 'user',
            foreignKey: 'userId'
        });
    };
    return Comment;
};
