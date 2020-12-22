const express = require('express');
const router = express.Router();
const { isLoggedIn, isAdmin, validate } = require('../middleware');

module.exports = (di) => {
    const photoController = di.get('controller.photo');

    router.get('/photos', [isLoggedIn], (...args) =>
        photoController.index(...args)
    );

    router.get('/photos/:id', [isLoggedIn], (...args) =>
        photoController.show(...args)
    );

    router.post('/photos/:id', [isLoggedIn, isAdmin], (...args) =>
        photoController.create(...args)
    );

    router.delete('/photos/:id', [isLoggedIn, isAdmin], (...args) =>
        photoController.delete(...args)
    );

    return router;
};
