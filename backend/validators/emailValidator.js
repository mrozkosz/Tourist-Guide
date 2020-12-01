const { body } = require('express-validator');
const { User } = require('../models');

module.exports = [
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
            const user = await User.findOne({
                where: {
                    email
                }
            });

            if (!user) {
                return Promise.reject('Email address does not exists!');
            }

            req.user = user;
        })
];
