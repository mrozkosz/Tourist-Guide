const config = require('../config');
const jwt = require('jsonwebtoken');

module.exports = (token) => {
    if (token === undefined) {
        return null;
    }

    try {
        const decoded = jwt.verify(token, config.auth.secretKey);

        return decoded;
    } catch (err) {
        console.error(err);

        return null;
    }
};
