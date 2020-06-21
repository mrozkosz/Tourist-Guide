const { body } = require('express-validator');
const { User } = require('../models');

const update = [
    body(['email'])
        .trim()
        .not()
        .isEmpty()
        .withMessage('should be not empty')
        .bail()
        .isEmail()
        .withMessage('Email address is not valid!')
        .bail()
        .custom(async (email, { req }) => {
            const { id } = req.params;
            const user = await User.findOne({
                where: {
                    email
                }
            });

            if (user && id !== user.id) {
                return Promise.reject('Email address already exists!');
            }
        }),

    body('firstName')
        .trim()
        .not()
        .isEmpty()
        .withMessage('should be not empty')
        .bail()
        .isLength({ min: 3 })
        .withMessage('lenghth is invalid'),

    body('lastName')
        .trim()
        .not()
        .isEmpty()
        .withMessage('should be not empty')
        .bail()
        .isLength({ min: 3 })
        .withMessage('lenghth is invalid'),

    body(['dayOfBirth'])
        .not()
        .isEmpty()
        .withMessage('should be not empty')
        .toDate()
];

const create = [
    ...update,

    body(['password'])
        .trim()
        .not()
        .isEmpty()
        .withMessage('should be not empty')
        .bail()
        .isLength({ min: 6, max: 32 })
        .withMessage('Password must be 6-32 characters in length')
];

module.exports = {
    create,
    update
};
