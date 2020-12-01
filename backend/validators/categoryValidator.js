const { body } = require('express-validator');
const { Category } = require('../models');

const create = [
    body(['name']).trim().not().isEmpty().withMessage('should be not empty')
];

const update = [
    body(['name'])
        .trim()
        .not()
        .isEmpty()
        .withMessage('should be not empty')
        .bail()
        .custom(async (name, { req }) => {
            const category = await Category.findOne({
                where: {
                    name
                }
            });

            if (category) {
                return Promise.reject('Category already exists!');
            }
        })
];

module.exports = {
    create,
    update
};
