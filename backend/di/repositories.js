const UserRepository = require('../repositories/UserRepository');
const RecoverPasswordRepository = require('../repositories/RecoverPasswordRepository');
const RoleRepository = require('../repositories/RoleRepository');

module.exports = (container) => {
    container.register('repositories.user', UserRepository);

    container.register(
        'repositories.recoverPassword',
        RecoverPasswordRepository
    );

    container.register('repositories.role', RoleRepository);
};
