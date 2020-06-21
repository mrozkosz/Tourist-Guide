const express = require('express');
const router = express.Router();
const { isLoggedIn, isRecoverHash, validate } = require('../middleware');
const recoverPassword = require('../validators/recoverPassword');
const emailValidator = require('../validators/emailValidator');

module.exports = (di) => {
    const authController = di.get('controller.auth');

    router.get('/me', [isLoggedIn], (...args) => authController.me(...args));
    router.post('/login', (...args) => authController.login(...args));
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
