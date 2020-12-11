const faker = require('faker');
const { RecoverPassword } = require('../../models');
const moment = require('moment');
const crypto = require('crypto');

class RecoverPasswordFactory {
    static generate(props) {
        const userId = faker.random.number({ min: 1, max: 999 });
        const hash = crypto.randomBytes(10).toString('hex');
        const expireIn = moment().add(14400000, 'ms');
        const defaultProps = {
            userId,
            hash,
            expireIn
        };

        return { ...defaultProps, ...props };
    }

    static build(props) {
        return RecoverPassword.build(RecoverPasswordFactory.generate(props));
    }

    static create(props) {
        return RecoverPassword.create(RecoverPasswordFactory.generate(props));
    }
}

module.exports = RecoverPasswordFactory;
