const express = require('express');
const router = express.Router();
const {
    isLoggedIn,
    isRecoverHash,
    validate,
    isRefreshToken
} = require('../middleware');
const recoverPassword = require('../validators/recoverPassword');
const emailValidator = require('../validators/emailValidator');
const tokenValidator = require('../validators/tokenValidator');

module.exports = (di) => {
    const authController = di.get('controller.auth');

    router.get('/me', [isLoggedIn], (...args) => authController.me(...args));

    router.post('/login', [emailValidator, validate], (...args) =>
        authController.login(...args)
    );

    router.post('/login/facebook', [tokenValidator, validate], (...args) =>
        authController.loginByFacebook(...args)
    );

    router.post(
        '/refresh-token',
        [tokenValidator, validate],
        isRefreshToken,
        (...args) => authController.refreshToken(...args)
    );

    router.post('/recover-password', [emailValidator, validate], (...args) =>
        authController.recoverPasswordSendMail(...args)
    );

    router.post(
        '/recover-password/:hash',
        [recoverPassword, validate],
        isRecoverHash,
        (...args) => authController.recoverPassword(...args)
    );

    return router;
};
