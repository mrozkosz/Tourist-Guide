const { Reference } = require('node-dependency-injection');
const AuthController = require('../controllers/AuthController');
const ContractController = require('../controllers/ContractController');
const EmployeeController = require('../controllers/EmployeeController');
const VacationDayController = require('../controllers/VacationDayController');

module.exports = (container) => {
    container
        .register('controller.auth', AuthController)
        .addArgument(new Reference('services.loginHandler'))
        .addArgument(
            new Reference('services.sendEmailToRecoverPasswordHandler')
        )
        .addArgument(new Reference('repositories.recoverPassword'));

    container
        .register('controller.contract', ContractController)
        .addArgument(new Reference('repositories.user'))
        .addArgument(new Reference('repositories.contract'));

    container
        .register('controller.employee', EmployeeController)
        .addArgument(new Reference('services.sendEmailToNewUserHandler'))
        .addArgument(new Reference('repositories.user'))
        .addArgument(new Reference('repositories.recoverPassword'))
        .addArgument(new Reference('repositories.role'));

    container
        .register('controller.vacationDayController', VacationDayController)
        .addArgument(new Reference('repositories.contract'))
        .addArgument(new Reference('repositories.vacationDay'));
};
