const { User } = require('../models');
const HttpStatuses = require('http-status-codes');
const decodeToken = require('../helpers/decodeToken');

module.exports = async (req, res, next) => {
    const token = req.headers.authorization;

    if (token === null) {
        return false;
    }

    const decoded = decodeToken(token);

    if (decoded === null) {
        return res
            .status(HttpStatuses.UNAUTHORIZED)
            .send({ message: 'Invalid token' });
    }

    const user = await User.findOne({
        where: {
            id: decoded.id,
            email: decoded.userEmail
        }
    });

    if (!user) {
        return res.sendStatus(HttpStatuses.UNAUTHORIZED);
    }

    req.loggedUser = user;

    return next();
};
