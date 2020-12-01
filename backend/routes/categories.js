const express = require('express');
const router = express.Router();
const { isLoggedIn, isAdmin, validate } = require('../middleware');
const categoryValidator = require('../validators/categoryValidator');

module.exports = (di) => {
    const categoryController = di.get('controller.category');

    router.get('/category', (...args) => categoryController.index(...args));

    router.get('/category/:id', (...args) => categoryController.show(...args));

    router.post(
        '/category',
        [isLoggedIn, isAdmin],
        [categoryValidator.create, validate],
        (...args) => categoryController.create(...args)
    );

    router.put(
        '/category/:id',
        [isLoggedIn, isAdmin],
        [categoryValidator.update, validate],
        (...args) => categoryController.update(...args)
    );

    router.delete('/category/:id', [isLoggedIn, isAdmin], (...args) =>
        categoryController.delete(...args)
    );

    return router;
};
