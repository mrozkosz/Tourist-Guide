const HttpStatuses = require('http-status-codes');
const moment = require('moment');

class VacationDayController {
    constructor(contractRepository, vacationDayRepository) {
        this.contractRepository = contractRepository;
        this.vacationDayRepository = vacationDayRepository;
    }

    async show(req, res) {
        const { id } = req.params;

        const contract = await this.contractRepository.findById(id, {
            include: [
                {
                    association: 'vacationDays'
                }
            ],
            subQuery: false
        });

        return res.send(contract);
    }

    async create(req, res) {
        const { isAdmin, contract } = req;
        const { contractId, startDay, stopDay } = req.body;

        const startAt = moment(startDay);
        const stopAt = moment(stopDay);

        const createdVacationDay = await this.vacationDayRepository.create({
            userId: contract.userId,
            contractId,
            startDay,
            stopDay,
            days: Math.abs(startAt.diff(stopAt, 'days')),
            isApproved: isAdmin ? true : false
        });

        return res.status(201).send(createdVacationDay);
    }

    async update(req, res) {
        const { params, isAdmin, isApproved } = req;
        const { startDay, stopDay } = req.body;

        const vacationDay = await this.vacationDayRepository.findById(
            params.id
        );

        if (!vacationDay) {
            return res.sendStatus(HttpStatuses.NOT_FOUND);
        }

        if (!isAdmin && vacationDay.isApproved) {
            return res.status(HttpStatuses.UNPROCESSABLE_ENTITY).send({
                message: 'Vacations has been approved, you can not edit it.'
            });
        }

        const startAt = moment(startDay ? startDay : vacationDay.startDay);
        const stopAt = moment(stopDay ? stopDay : vacationDay.stopDay);

        const updatedVacationDay = await vacationDay.update({
            isApproved,
            startDay: startAt,
            stopDay: stopAt,
            days: Math.abs(startAt.diff(stopAt, 'days'))
        });

        return res.send(updatedVacationDay);
    }

    async delete(req, res) {
        const { id: vacationDayId } = req.params;

        const vacationDay = await this.vacationDayRepository.findById(
            vacationDayId
        );

        if (!vacationDay) {
            return res.sendStatus(HttpStatuses.NO_CONTENT);
        }

        await vacationDay.destroy();

        return res.sendStatus(HttpStatuses.NO_CONTENT);
    }
}

module.exports = VacationDayController;
