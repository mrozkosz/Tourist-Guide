const { body } = require('express-validator');
const { userRepository } = require('../models');

const update = [
    body(['firstName'])
        .trim()
        .not()
        .isEmpty()
        .withMessage('Should not be empty')
        .bail()
        .isLength({ min: 3, max: 255 })
        .withMessage(
            'Invalid name format. Min length is 3 chars. Max length is 255 chars'
        ),

    body(['lastName'])
        .trim()
        .not()
        .isEmpty()
        .withMessage('Should not be empty')
        .bail()
        .isLength({ min: 3, max: 255 })
        .withMessage(
            'Invalid surname format. Min length is 3 chars. Max length is 255 chars'
        ),

    body('email')
        .trim()
        .not()
        .isEmpty()
        .withMessage('Should not be empty')
        .bail()
        .isEmail()
        .withMessage('Email address is not valid!')
        .bail()
        .normalizeEmail()
        .custom(async (email, { req }) => {
            const di = req.app.get('di');
            const userRepository = di.get('repositories.user');

            const { id } = req.params;
            const user = await userRepository.findByEmail(email);

            if (user && id !== user.id) {
                return Promise.reject('Email address already exists!');
            }
        })
];

const create = [...update];

create.push(
    body('password')
        .trim()
        .not()
        .isEmpty()
        .withMessage('Should not be empty')
        .bail()
        .isLength({ min: 6, max: 32 })
        .withMessage('Password must be 6-32 characters in length')
);

module.exports = {
    create,
    update
};
