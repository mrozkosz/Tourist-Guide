const express = require('express');
const router = express.Router();
const fs = require('fs');

module.exports = (di, io) => {
    fs.readdirSync(__dirname).forEach((route) => {
        route = route.split('.')[0];

        if (route === 'index') {
            return;
        }

        if (route === 'webSocket') {
            return;
        }

        router.use(require(`./${route}`)(di));
    });

    router.use(require('./webSocket')(di, io));

    return router;
};
