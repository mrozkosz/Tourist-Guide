const express = require('express');
const router = express.Router();
const { isLoggedIn, isAdmin, validate } = require('../middleware');
const pleaceValidator = require('../validators/pleaceValidator');

module.exports = (di) => {
    const pleaceController = di.get('controller.pleace');

    router.get('/pleaces', [isLoggedIn], (...args) =>
        pleaceController.index(...args)
    );

    router.get('/pleaces/:id', [isLoggedIn], (...args) =>
        pleaceController.show(...args)
    );

    router.post(
        '/pleaces',
        [isLoggedIn, isAdmin],
        [pleaceValidator.create, validate],
        (...args) => pleaceController.create(...args)
    );

    router.put(
        '/pleaces/:id',
        [isLoggedIn, isAdmin],
        [pleaceValidator.update, validate],
        (...args) => pleaceController.update(...args)
    );

    router.delete('/pleaces/:id', [isLoggedIn, isAdmin], (...args) =>
        pleaceController.delete(...args)
    );

    return router;
};
