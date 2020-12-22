const AbstractRepository = require('./AbstractRepository');
const { View } = require('../models');

class ViewRepository extends AbstractRepository {
    get model() {
        return View;
    }
}

module.exports = ViewRepository;
