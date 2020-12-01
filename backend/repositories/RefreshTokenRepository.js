const AbstractRepository = require('./AbstractRepository');
const { RefreshToken } = require('../models');

class RefreshTokenRepository extends AbstractRepository {
    get model() {
        return RefreshToken;
    }
}

module.exports = RefreshTokenRepository;
