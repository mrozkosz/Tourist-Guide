const express = require('express');
const router = express.Router();
const vacationsValidator = require('../validators/vacationsValidator');
const { isLoggedIn, isAdmin, validate, isEmployee } = require('../middleware');

module.exports = (di) => {
    const VacationDayController = di.get('controller.vacationDayController');

    router.get('/vacations/:id', [isLoggedIn, isAdmin], (...args) =>
        VacationDayController.show(...args)
    );

    router.post(
        '/vacations',
        [isLoggedIn, isEmployee],
        [vacationsValidator.create, validate],
        (...args) => VacationDayController.create(...args)
    );

    router.put(
        '/vacations/:id',
        [isLoggedIn, isEmployee],
        [vacationsValidator.update, validate],
        (...args) => VacationDayController.update(...args)
    );

    router.delete('/vacations/:id', [isLoggedIn, isAdmin], (...args) =>
        VacationDayController.delete(...args)
    );

    return router;
};
