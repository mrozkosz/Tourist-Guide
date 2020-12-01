const AbstractRepository = require('./AbstractRepository');
const { User } = require('../models');

class UserRepository extends AbstractRepository {
    get model() {
        return User;
    }
}

module.exports = UserRepository;
