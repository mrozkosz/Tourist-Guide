const { body } = require('express-validator');
const { Pleace, Beacon } = require('../models');

module.exports = [
    body(['pleaceId'])
        .trim()
        .not()
        .isEmpty()
        .withMessage('should be not empty')
        .bail()
        .custom(async (pleaceId, { req }) => {
            const pleace = await Pleace.findOne({
                where: {
                    id: pleaceId
                }
            });

            if (!pleace) {
                return Promise.reject('Pleace does not exists!');
            }
        }),

    body(['uuid'])
        .trim()
        .not()
        .isEmpty()
        .withMessage('should be not empty')
        .bail()
        .custom(async (uuid, { req }) => {
            const beacon = await Beacon.findOne({
                where: {
                    uuid
                }
            });

            if (beacon) {
                return Promise.reject('Beacon is already in use!');
            }
        })
];
