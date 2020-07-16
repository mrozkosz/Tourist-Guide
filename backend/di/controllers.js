const { Reference } = require('node-dependency-injection');
const AuthController = require('../controllers/AuthController');

module.exports = (container) => {
    container
        .register('controller.auth', AuthController)
        .addArgument(new Reference('services.loginHandler'))
        .addArgument(
            new Reference('services.sendEmailToRecoverPasswordHandler')
        )
        .addArgument(new Reference('repositories.recoverPassword'));
};
