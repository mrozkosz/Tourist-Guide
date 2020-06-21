const fs = require('fs');
const path = require('path');
const Sequelize = require('sequelize');

const basename = path.basename(__filename);
const config = require('../config');

const db = {};

let sequelize;

if (config.db.url) {
    const id = Math.random().toString(36).substring(2);

    sequelize = new Sequelize(config.db.url, { ...config.db });
} else {
    sequelize = new Sequelize(
        config.db.name,
        config.db.username,
        config.password,
        { ...config.db }
    );
}

fs.readdirSync(__dirname)
    .filter(
        (file) =>
            file.indexOf('.') !== 0 &&
            file !== basename &&
            file.slice(-3) === '.js'
    )
    .forEach((file) => {
        const model = sequelize.import(path.join(__dirname, file));
        db[model.name] = model;
    });

Object.keys(db).forEach((modelName) => {
    if (db[modelName].associate) {
        db[modelName].associate(db);
    }
});

/**
 * Monkey patch issue causing deprecation warning when customizing allowNull validation error
 *
 * See https://github.com/sequelize/sequelize/issues/1500
 */
Sequelize.Validator.notNull = function (item) {
    return !this.isNull(item);
};

db.sequelize = sequelize;
db.Sequelize = Sequelize;

module.exports = db;
