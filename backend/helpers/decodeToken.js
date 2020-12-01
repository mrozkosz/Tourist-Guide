const config = require('../config');
const jwt = require('jsonwebtoken');

module.exports = (token) => {
    if (!token) {
        return null;
    }

    const BEARER = 'Bearer';
    const authorizationToken = token.split(' ');

    if (authorizationToken[0] !== BEARER) {
        return null;
    }

    try {
        const decoded = jwt.verify(
            authorizationToken[1],
            config.auth.secretKey
        );

        return decoded;
    } catch (err) {
        console.error('invalid token');

        return null;
    }
};
