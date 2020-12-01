const AbstractRepository = require('./AbstractRepository');
const { PleaceCategory } = require('../models');

class PleaceCategoryRepository extends AbstractRepository {
    get model() {
        return PleaceCategory;
    }
}

module.exports = PleaceCategoryRepository;
