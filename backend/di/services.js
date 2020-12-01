const { Reference, Definition } = require('node-dependency-injection');
const LoginHandler = require('../services/LoginHandler');
const MailerFactory = require('../services/MailerFactory');
const SendEmailToRecoverPasswordHandler = require('../services/mailer/SendEmailToRecoverPasswordHandler');
const SendEmailToNewUserHandler = require('../services/mailer/SendEmailToNewUserHandler');
const config = require('../config');
const { User, Role } = require('../models');

module.exports = (container) => {
    const definitionFactory = new Definition();

    definitionFactory.setFactory(MailerFactory, 'create');
    definitionFactory.args = [config.email];
    container.setDefinition('services.mailerFactory', definitionFactory);

    container
        .register('services.loginHandler', LoginHandler)
        .addArgument(User)
        .addArgument(Role);

    container
        .register(
            'services.sendEmailToRecoverPasswordHandler',
            SendEmailToRecoverPasswordHandler
        )
        .addArgument(new Reference('services.mailerFactory'))
        .addArgument(config);

    container
        .register(
            'services.sendEmailToNewUserHandler',
            SendEmailToNewUserHandler
        )
        .addArgument(new Reference('services.mailerFactory'))
        .addArgument(config);
};
