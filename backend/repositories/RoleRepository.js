const AbstractRepository = require('./AbstractRepository');
const { Role } = require('../models');

class RoleRepository extends AbstractRepository {
    get model() {
        return Role;
    }
}

module.exports = RoleRepository;
