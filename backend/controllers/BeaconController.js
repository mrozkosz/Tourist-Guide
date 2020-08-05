const HttpStatuses = require('http-status-codes');

class BeaconController {
    constructor(beaconRepository, pleaceRepository) {
        this.beaconRepository = beaconRepository;
        this.pleaceRepository = pleaceRepository;
    }

    async show(req, res) {
        const { body } = req;

        if (!Array.isArray(body)) {
            return res.sendStatus(HttpStatuses.BAD_REQUEST);
        }

        let uuid = [...new Set(body)];

        const pleaceIds = await this.beaconRepository.findAll({
            where: { uuid },
            attributes: ['pleaceId'],
            row: false
        });

        const where = {};

        where.id = pleaceIds.map((value) => {
            return value.pleaceId;
        });

        const pleaces = await this.pleaceRepository.findAll({
            where,
            include: [
                {
                    association: 'photos'
                }
            ]
        });

        return res.send({
            pleaces
        });
    }

    async edit(req, res) {}

    async delete(req, res) {
        const { id } = req.params;

        const beacon = await this.beaconRepository.findOne({ where: { id } });

        if (beacon) {
            await beacon.destroy();
        }

        return res.sendStatus(HttpStatuses.NO_CONTENT);
    }

    async create(req, res) {
        const { uuid } = req.body;
        const { pleace } = req;

        await this.beaconRepository.create(req.body);

        return res.send({
            uuid,
            pleace
        });
    }
}

module.exports = BeaconController;
