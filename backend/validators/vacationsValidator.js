const { body } = require('express-validator');
const { Contract, VacationDay } = require('../models');

const create = [
    body('contractId')
        .trim()
        .not()
        .isEmpty()
        .withMessage('should be not empty')
        .bail()
        .custom(async (contractId, { req }) => {
            const contract = await Contract.findByPk(contractId);

            if (!contract) {
                return Promise.reject('Contract does not exist!');
            }

            req.contract = contract;
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
        .toDate()
];

const update = [
    ...create,

    body('isApproved').custom(async (isApproved, { req }) => {
        const { isAdmin } = req;

        if (!isAdmin) {
            req.isApproved = false;
        }
        req.isApproved = isApproved;
    })
];

module.exports = {
    create,
    update
};
