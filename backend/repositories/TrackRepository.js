const AbstractRepository = require('./AbstractRepository');
const { Track } = require('../models');

class TrackRepository extends AbstractRepository {
    get model() {
        return Track;
    }
}

module.exports = TrackRepository;
