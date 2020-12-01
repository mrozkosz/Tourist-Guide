class SendEmailToRecoverPasswordHandler {
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
            subject: 'Recover password',
            text: '',
            html: `Use this url to reset password:
                <br><h2>${hash}</h2>`
        });
    }
}

module.exports = SendEmailToRecoverPasswordHandler;
