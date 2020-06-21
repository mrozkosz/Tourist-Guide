const express = require('express');
const router = express.Router();
const employeValidator = require('../validators/employeeValidator');
const { isLoggedIn, isAdmin, validate } = require('../middleware');

module.exports = (di) => {
    const employeeController = di.get('controller.employee');

    router.get(
        '/employees',
        [isLoggedIn, isAdmin],

        (...args) => employeeController.index(...args)
    );

    router.post(
        '/employees',
        [isLoggedIn, isAdmin],
        [employeValidator.create, validate],

        (...args) => employeeController.create(...args)
    );

    router.put(
        '/employees/:id',
        [isLoggedIn, isAdmin],
        [employeValidator.update, validate],
        (...args) => employeeController.update(...args)
    );

    router.delete('/employees/:id', [isLoggedIn, isAdmin], (...args) =>
        employeeController.delete(...args)
    );

    return router;
};
