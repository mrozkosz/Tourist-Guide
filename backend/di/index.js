const { ContainerBuilder } = require('node-dependency-injection');
const fs = require('fs');

const container = new ContainerBuilder();

const files = fs.readdirSync(__dirname);

for (let file of files) {
    file = file.split('.')[0];

    if (file === 'index') {
        continue;
    }

    require(`./${file}`)(container);
}

module.exports = container;
