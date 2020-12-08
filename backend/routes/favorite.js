const express = require('express');
const router = express.Router();
const { isLoggedIn } = require('../middleware');

module.exports = (di) => {
    const favoriteController = di.get('controller.favorite');

    router.get('/favorites', [isLoggedIn], (...args) =>
        favoriteController.index(...args)
    );

    router.get('/favorites/:id', [isLoggedIn], (...args) =>
        favoriteController.show(...args)
    );

    router.put('/favorites/:id', [isLoggedIn], (...args) =>
        favoriteController.createOrUpdate(...args)
    );

    return router;
};
