const HttpStatuses = require('http-status-codes');
const { RefreshToken } = require('../models');
const moment = require('moment');
const decodeToken = require('../helpers/decodeToken');

module.exports = async (req, res, next) => {
    const { token } = req.body;

    if (!token) {
        return res.sendStatus(HttpStatuses.UNAUTHORIZED);
    }

    const decoded = decodeToken(`Bearer ${token}`);

    if (decoded === null) {
        return res.status(401).send({ message: 'Invalid token' });
    }

    const { hash } = decoded;

    const refreshToken = await RefreshToken.findOne({
        where: {
            hash
        },
        include: [
            {
                association: 'user'
            }
        ]
    });

    if (!refreshToken) {
        return res
            .status(HttpStatuses.UNAUTHORIZED)
            .send({ message: 'Token does not exist' });
    }

    const expireIn = moment(refreshToken.expireIn);
    const now = moment(new Date());

    if (now >= expireIn) {
        return res.send({ message: 'Token has expired' });
    }

    req.refreshToken = refreshToken;

    return next();
};
