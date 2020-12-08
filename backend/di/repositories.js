const UserRepository = require('../repositories/UserRepository');
const RecoverPasswordRepository = require('../repositories/RecoverPasswordRepository');
const RoleRepository = require('../repositories/RoleRepository');
const BeaconRepository = require('../repositories/BeaconRepository');
const PleaceRepository = require('../repositories/PleaceRepository');
const CategoryRepository = require('../repositories/CategoryRepository');
const PleaceCategoryRepository = require('../repositories/PleaceCategoryRepository');
const RefreshTokenRepository = require('../repositories/RefreshTokenRepository');
const CommentRepository = require('../repositories/CommentRepository');
const FavoriteRepository = require('../repositories/FavoriteRepository');

module.exports = (container) => {
    container.register('repositories.user', UserRepository);

    container.register(
        'repositories.recoverPassword',
        RecoverPasswordRepository
    );

    container.register('repositories.role', RoleRepository);

    container.register('repositories.beacon', BeaconRepository);

    container.register('repositories.pleace', PleaceRepository);

    container.register('repositories.category', CategoryRepository);

    container.register('repositories.pleaceCategory', PleaceCategoryRepository);

    container.register('repositories.refreshToken', RefreshTokenRepository);

    container.register('repositories.comment', CommentRepository);

    container.register('repositories.favorite', FavoriteRepository);
};
