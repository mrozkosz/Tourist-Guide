const express = require('express');
const router = express.Router();
const { isLoggedIn } = require('../middleware');

module.exports = (di) => {
    const homeController = di.get('controller.home');

    router.get('/home', [isLoggedIn], (...args) =>
        homeController.index(...args)
    );

    return router;
};
