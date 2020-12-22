const faker = require('faker');
const { Pleace } = require('../../models');

class PleaceFactory {
    static generate(props) {
        const defaultProps = {
            coverImage: 'RGq0aLUVqP4boCk.jpeg',
            location: faker.random.locale.name,
            name: faker.name.title(),
            description: faker.random.words(500),
            lat: '50.00',
            long: '19.00'
        };

        return Object.assign({}, defaultProps, props);
    }

    static build(props) {
        return Pleace.build(PleaceFactory.generate(props));
    }

    static create(props) {
        return Pleace.create(PleaceFactory.generate(props));
    }
}

module.exports = PleaceFactory;
