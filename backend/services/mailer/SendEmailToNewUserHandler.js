class SendEmailToNewUsersHandler {
    constructor(transporter, config) {
        this.transporter = transporter;
        this.config = config;
    }

    async handle(user, hash) {
        const { email, app } = this.config;
        const recoverPasswordLink = `${app.frontendUrl}/recover-password/${hash}`;

        await this.transporter.sendMail({
            from: email.auth.user,
            to: user.email,
            subject: 'Your Account',
            text: '',
            html: `Your new account has been created.
            First Name:${user.firstName},
            Last Name: ${user.lastName},
            Click this :<br><a href='${recoverPasswordLink}'>LINK</a> to reset password.`
        });
    }
}

module.exports = SendEmailToNewUsersHandler;
