const AbstractRepository = require('./AbstractRepository');
const { Pleace } = require('../models');

class PleaceRepository extends AbstractRepository {
    get model() {
        return Pleace;
    }
}

module.exports = PleaceRepository;
