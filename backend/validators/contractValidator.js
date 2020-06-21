const { body } = require('express-validator');
const { User } = require('../models');

module.exports = [
    body('userId')
        .not()
        .isEmpty()
        .withMessage('should be not empty')
        .custom(async (userId, { req }) => {
            const user = await User.findOne({
                where: {
                    id: userId
                }
            });

            if (user === null) {
                return Promise.reject('User does not exists!');
            }

            req.user = user;
        }),

    body(['startDay'])
        .not()
        .isEmpty()
        .withMessage('should be not empty')
        .toDate(),

    body(['stopDay'])
        .not()
        .isEmpty()
        .withMessage('should be not empty')
        .toDate(),

    body('duration').trim().not().isEmpty().withMessage('should be not empty'),

    body('freeDays').trim().not().isEmpty().withMessage('should be not empty')
];
