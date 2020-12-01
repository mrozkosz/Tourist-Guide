const { body } = require('express-validator');

module.exports = [
    body(['token']).trim().not().isEmpty().withMessage('should be not empty')
];
