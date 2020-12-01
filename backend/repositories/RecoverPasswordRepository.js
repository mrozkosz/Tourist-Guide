const AbstractRepository = require('./AbstractRepository');
const { RecoverPassword } = require('../models');

class RecoverPasswordRepository extends AbstractRepository {
    get model() {
        return RecoverPassword;
    }
}

module.exports = RecoverPasswordRepository;
