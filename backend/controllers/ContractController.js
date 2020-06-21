const HttpStatuses = require('http-status-codes');
const moment = require('moment');

class ContractController {
    constructor(userRepository, contractRepository) {
        this.userRepository = userRepository;
        this.contractRepository = contractRepository;
    }

    async index(req, res) {
        const { isAdmin, loggedUser } = req;
        console.log(isAdmin);
        if (!isAdmin) {
            const contracts = await this.userRepository.findOne(loggedUser.id, {
                include: [
                    {
                        association: 'contracts',
                        include: { association: 'vacationDays' }
                    }
                ]
            });

            return res.send(contracts);
        }

        const contracts = await this.userRepository.findAll({
            include: [
                {
                    association: 'contracts',
                    include: { association: 'vacationDays' }
                }
            ]
        });

        return res.send(contracts);
    }

    async create(req, res) {
        const { duration, startDay, stopDay } = req.body;

        if (!stopDay) {
            req.body.stopDay = moment(startDay)
                .add(duration, 'M')
                .subtract(1, 'd');
        }

        const contract = await this.contractRepository.create(req.body);

        return res.status(201).send(contract);
    }

    async update(req, res) {
        const { id: contractId } = req.params;

        const contract = await this.contractRepository.findById(contractId);

        if (!contract) {
            return res.sendStatus(HttpStatuses.NOT_FOUND);
        }

        const updatedContract = await contract.update(req.body);

        return res.send(updatedContract);
    }

    async delete(req, res) {
        const { id: contractId } = req.params;

        const contract = await this.contractRepository.findById(contractId);

        if (contract) {
            await contract.destroy();
        }

        return res.sendStatus(HttpStatuses.NO_CONTENT);
    }
}

module.exports = ContractController;
