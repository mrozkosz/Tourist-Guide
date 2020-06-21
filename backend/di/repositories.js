const UserRepository = require('../repositories/UserRepository');
const ContractRepository = require('../repositories/ContractRepository');
const RecoverPasswordRepository = require('../repositories/RecoverPasswordRepository');
const RoleRepository = require('../repositories/RoleRepository');
const VacationDayRepository = require('../repositories/VacationDayRepository');

module.exports = (container) => {
    container.register('repositories.user', UserRepository);

    container.register('repositories.contract', ContractRepository);

    container.register(
        'repositories.recoverPassword',
        RecoverPasswordRepository
    );

    container.register('repositories.role', RoleRepository);

    container.register('repositories.vacationDay', VacationDayRepository);
};
