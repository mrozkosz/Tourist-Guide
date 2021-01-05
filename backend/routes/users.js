const express = require('express');
const router = express.Router();
const {
    isLoggedIn,
    isAdmin,
    adminIsNotRequired,
    validate
} = require('../middleware');
const userValidator = require('../validators/userValidator');

module.exports = (di) => {
    const userController = di.get('controller.user');

    router.get('/users', [isLoggedIn, isAdmin], (...args) =>
        userController.index(...args)
    );

    router.get('/users/:id', [isLoggedIn, adminIsNotRequired], (...args) =>
        userController.show(...args)
    );

    router.post('/users', [userValidator.create, validate], (...args) =>
        userController.create(...args)
    );

    router.put('/users/:id', [userValidator.update, validate], (...args) =>
        userController.update(...args)
    );

    router.delete('/users/:id', [isLoggedIn, isAdmin], (...args) =>
        userController.delete(...args)
    );

    return router;
};
