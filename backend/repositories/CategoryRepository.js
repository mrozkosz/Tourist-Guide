const AbstractRepository = require('./AbstractRepository');
const { Category } = require('../models');

class CategoryRepository extends AbstractRepository {
    get model() {
        return Category;
    }
}

module.exports = CategoryRepository;
