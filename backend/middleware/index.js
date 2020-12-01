const validate = require('./validate');
const isAdmin = require('./isAdmin');
const isLoggedIn = require('./isLoggedIn');
const isRecoverHash = require('./isRecoverHash');
const isEmployee = require('./isEmployee');
const isRefreshToken = require('./isRefreshToken');

module.exports = {
    validate,
    isAdmin,
    isLoggedIn,
    isRecoverHash,
    isEmployee,
    isRefreshToken
};
