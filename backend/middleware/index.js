const validate = require('./validate');
const isAdmin = require('./isAdmin');
const isLoggedIn = require('./isLoggedIn');
const isRecoverHash = require('./isRecoverHash');

const isRefreshToken = require('./isRefreshToken');

module.exports = {
    validate,
    isAdmin,
    isLoggedIn,
    isRecoverHash,
    isRefreshToken
};
