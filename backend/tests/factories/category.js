const faker = require('faker');
const { Category } = require('../../models');

class CategoryFactory {
    static generate(props) {
        const defaultProps = {
            name: faker.random.word()
        };

        return Object.assign({}, defaultProps, props);
    }

    static build(props) {
        return Category.build(CategoryFactory.generate(props));
    }

    static create(props) {
        return Category.create(CategoryFactory.generate(props));
    }
}

module.exports = CategoryFactory;
