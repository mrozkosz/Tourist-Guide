const express = require('express');
const router = express.Router();
const { isLoggedIn, isAdmin, validate } = require('../middleware');
const beaconValidator = require('../validators/beaconValidator');

module.exports = (di) => {
    const beaconController = di.get('controller.beacon');

    router.get('/beacons', (...args) => beaconController.show(...args));

    router.post(
        '/beacons',
        [isLoggedIn, isAdmin],
        [beaconValidator, validate],
        (...args) => beaconController.create(...args)
    );

    router.delete('/beacons/:id', [isLoggedIn, isAdmin], (...args) =>
        beaconController.delete(...args)
    );

    return router;
};
