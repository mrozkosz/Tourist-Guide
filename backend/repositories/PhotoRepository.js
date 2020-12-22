const AbstractRepository = require('./AbstractRepository');
const { Photo } = require('../models');

class PhotoRepository extends AbstractRepository {
    get model() {
        return Photo;
    }
}

module.exports = PhotoRepository;
