const AbstractRepository = require('./AbstractRepository');
const { Favorite } = require('../models');

class FavoriteRepository extends AbstractRepository {
    get model() {
        return Favorite;
    }
}

module.exports = FavoriteRepository;
