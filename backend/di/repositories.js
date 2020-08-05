const UserRepository = require('../repositories/UserRepository');
const RecoverPasswordRepository = require('../repositories/RecoverPasswordRepository');
const RoleRepository = require('../repositories/RoleRepository');
const BeaconRepository = require('../repositories/BeaconRepository');
const PleaceRepository = require('../repositories/PleaceRepository');

module.exports = (container) => {
    container.register('repositories.user', UserRepository);

    container.register(
        'repositories.recoverPassword',
        RecoverPasswordRepository
    );

    container.register('repositories.role', RoleRepository);

    container.register('repositories.beacon', BeaconRepository);

    container.register('repositories.pleace', PleaceRepository);
};
