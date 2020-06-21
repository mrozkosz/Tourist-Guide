const AbstractRepository = require('./AbstractRepository');
const { VacationDay } = require('../models');

class VacationDayRepository extends AbstractRepository {
    get model() {
        return VacationDay;
    }
}

module.exports = VacationDayRepository;
