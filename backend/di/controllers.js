const { Reference } = require('node-dependency-injection');
const AuthController = require('../controllers/AuthController');
const BeaconController = require('../controllers/BeaconController');

module.exports = (container) => {
    container
        .register('controller.auth', AuthController)
        .addArgument(new Reference('services.loginHandler'))
        .addArgument(
            new Reference('services.sendEmailToRecoverPasswordHandler')
        )
        .addArgument(new Reference('repositories.recoverPassword'));

    container
        .register('controller.beacon', BeaconController)
        .addArgument(new Reference('repositories.beacon'))
        .addArgument(new Reference('repositories.pleace'));
};
