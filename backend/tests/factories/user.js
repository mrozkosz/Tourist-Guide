const faker = require('faker');
const { User } = require('../../models');

class UserFactory {
    static generate(props) {
        const defaultProps = {
            email: faker.internet.email(),
            firstName: faker.name.firstName(null),
            lastName: faker.name.lastName(null),
            password: faker.internet.password()
        };

        return Object.assign({}, defaultProps, props);
    }

    static build(props) {
        return User.build(UserFactory.generate(props));
    }

    static create(props) {
        return User.create(UserFactory.generate(props));
    }
}

module.exports = UserFactory;
