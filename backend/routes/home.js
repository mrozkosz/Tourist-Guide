const express = require('express');
const router = express.Router();
const { isLoggedIn } = require('../middleware');

module.exports = (di) => {
    const homeController = di.get('controller.home');

    router.get('/home', [isLoggedIn], (...args) =>
        homeController.index(...args)
    );

    router.get('/test', (...args) => homeController.test(...args));

    // router.put('/home', [isLoggedIn], (...args) =>
    //     homeController.createOrUpdate(...args)
    // );

    return router;
};
