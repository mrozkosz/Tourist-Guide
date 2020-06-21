const AbstractRepository = require('./AbstractRepository');
const { Contract } = require('../models');

class ContractRepository extends AbstractRepository {
    get model() {
        return Contract;
    }
}

module.exports = ContractRepository;
