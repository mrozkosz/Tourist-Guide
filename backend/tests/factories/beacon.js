const faker = require('faker');
const { Beacon } = require('../../models');

class BeaconFactory {
    static generate(props) {
        const defaultProps = {
            uuid: faker.random.uuid(),
            pleaceId: faker.random.number(99)
        };

        return Object.assign({}, defaultProps, props);
    }

    static build(props) {
        return Beacon.build(BeaconFactory.generate(props));
    }

    static create(props) {
        return Beacon.create(BeaconFactory.generate(props));
    }
}

module.exports = BeaconFactory;
