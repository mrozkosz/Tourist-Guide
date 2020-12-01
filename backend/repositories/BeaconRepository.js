const AbstractRepository = require('./AbstractRepository');
const { Beacon } = require('../models');

class BeaconRepository extends AbstractRepository {
    get model() {
        return Beacon;
    }
}

module.exports = BeaconRepository;
