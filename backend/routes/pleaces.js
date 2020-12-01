const express = require('express');
const router = express.Router();
const { isLoggedIn, isAdmin, validate } = require('../middleware');
const pleaceValidator = require('../validators/pleaceValidator');

module.exports = (di) => {
    const pleaceController = di.get('controller.pleace');

    router.get('/pleaces', (...args) => pleaceController.index(...args));

    router.get('/pleaces/:id', (...args) => pleaceController.show(...args));

    router.post(
        '/pleaces',
        [isLoggedIn, isAdmin],
        [pleaceValidator.create, validate],
        (...args) => pleaceController.create(...args)
    );

    router.put('/pleaces/:id', [isLoggedIn, isAdmin], (...args) =>
        pleaceController.update(...args)
    );

    router.delete('/pleaces/:id', [isLoggedIn, isAdmin], (...args) =>
        pleaceController.delete(...args)
    );

    router.get('/test', (...args) => pleaceController.test(...args));

    return router;
};
