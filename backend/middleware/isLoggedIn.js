const { User } = require('../models');
const decodeToken = require('../helpers/decodeToken');

module.exports = async (req, res, next) => {
    const token = req.headers.authorization;

    if (token === null) {
        return false;
    }
    const decoded = decodeToken(token);

    if (decoded === null) {
        return res.status(401).send({ message: 'Invalid token' });
    }

    req.loggedUser = await User.findByPk(decoded.user.id);

    return next();
};
