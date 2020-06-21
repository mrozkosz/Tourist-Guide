const HttpStatuses = require('http-status-codes');
const { RecoverPassword } = require('../models');
const moment = require('moment');

module.exports = async (req, res, next) => {
    const resetHash = req.params.hash;

    if (!resetHash) {
        return res.sendStatus(HttpStatuses.UNAUTHORIZED);
    }

    const recoverPassword = await RecoverPassword.findOne({
        where: {
            hash: resetHash
        },
        include: [
            {
                association: 'user'
            }
        ]
    });

    if (!recoverPassword) {
        return res
            .status(HttpStatuses.UNAUTHORIZED)
            .send({ message: 'Token does not exist' });
    }

    const expireIn = moment(recoverPassword.expireIn);
    const now = moment(new Date());

    if (now >= expireIn) {
        return res.send({ message: 'Token has expired' });
    }

    req.recoverPassword = recoverPassword;

    return next();
};
