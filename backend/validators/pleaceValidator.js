const { body } = require('express-validator');
const { Category } = require('../models');

const update = [
    body(['location'])
        .trim()
        .not()
        .isEmpty()
        .withMessage('should be not empty'),
    body(['name']).trim().not().isEmpty().withMessage('should be not empty'),

    body(['description'])
        .trim()
        .not()
        .isEmpty()
        .withMessage('should be not empty'),

    body(['lat']).trim().not().isEmpty().withMessage('should be not empty'),

    body(['long']).trim().not().isEmpty().withMessage('should be not empty')
];

const create = [...update];

create.push(
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
        }),

    body(['categorieId'])
        .trim()
        .not()
        .isEmpty()
        .withMessage('should be not empty')
        .bail()
        .custom(async (categorieId, { req }) => {
            const category = await Category.findOne({
                where: {
                    id: categorieId
                }
            });

            if (!category) {
                return Promise.reject('Category does not exists!');
            }
        })
);

module.exports = {
    create,
    update
};
