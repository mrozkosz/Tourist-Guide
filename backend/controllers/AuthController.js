const HttpStatuses = require('http-status-codes');
const config = require('../config');
const jwt = require('jsonwebtoken');
const bcrypt = require('bcryptjs');
const crypto = require('crypto');
const moment = require('moment');

class AuthController {
    constructor(
        loginHandler,
        sendEmailToRecoverPasswordHandler,
        recoverPasswordRepository
    ) {
        this.loginHandler = loginHandler;
        this.sendEmailToRecoverPasswordHandler = sendEmailToRecoverPasswordHandler;
        this.recoverPasswordRepository = recoverPasswordRepository;
    }

    async login(req, res) {
        const { email, password } = req.body;

        const user = await this.loginHandler.handle(email, password);

        if (!user) {
            return res.sendStatus(HttpStatuses.UNAUTHORIZED);
        }

        const token = jwt.sign({ user }, config.auth.secretKey, {
            expiresIn: config.auth.expiresIn
        });

        const expiresIn = moment().add(config.auth.expiresIn, 'ms');

        return res.send({
            token,
            expiresIn,
            user
        });
    }

    async me(req, res) {
        return res.send(req.loggedUser);
    }

    async recoverPasswordSendMail(req, res) {
        const hash = crypto.randomBytes(10).toString('hex');
        const { user } = req;
        const { expiresIn } = config.password;

        this.recoverPasswordRepository.create({
            userId: user.id,
            hash,
            expireIn: moment().add(expiresIn, 'ms')
        });

        this.sendEmailToRecoverPasswordHandler.handle(user, hash);

        return res.sendStatus(HttpStatuses.NO_CONTENT);
    }

    async recoverPassword(req, res) {
        const { user } = req.recoverPassword;
        const recover = req.recoverPassword;
        const { password } = req.body;

        await user.update({
            password: bcrypt.hashSync(password, 12)
        });

        await recover.destroy();

        return res.sendStatus(HttpStatuses.NO_CONTENT);
    }
}

module.exports = AuthController;
