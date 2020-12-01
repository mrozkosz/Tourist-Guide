const { body } = require('express-validator');
const { Category } = require('../models');

const create = [
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

    body(['categorieId'])
        .trim()
        .not()
        .isEmpty()
        .withMessage('should be not empty')
        .bail()
        .custom(async (categorieId, { req }) => {
            console.log(req.files);
            const category = await Category.findOne({
                where: {
                    id: categorieId
                }
            });

            if (!category) {
                return Promise.reject('Category does not exists!');
            }
        })
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
