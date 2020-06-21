const nodemailer = require('nodemailer');

class MailerFactory {
    static create(emailConfig) {
        return nodemailer.createTransport(emailConfig);
    }
}

module.exports = MailerFactory;
