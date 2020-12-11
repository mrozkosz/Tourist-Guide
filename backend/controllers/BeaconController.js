const HttpStatuses = require('http-status-codes');

class BeaconController {
    constructor(beaconRepository, pleaceRepository) {
        this.beaconRepository = beaconRepository;
        this.pleaceRepository = pleaceRepository;
    }

    async index(req, res) {
        const {
            perPage = 5,
            page = 1,
            sortBy = 'createdAt',
            order = 'desc'
        } = req.query;

        const pageNumber = parseInt(page);
        const limit = parseInt(perPage);

        const offset = (pageNumber - 1) * limit;

        const where = {};

        const categories = await this.beaconRepository.findAndCountAll({
            where,
            offset,
            limit,
            order: [[sortBy, order]]
        });

        const totalPages = Math.ceil(categories.count / limit);

        return res.send({ totalPages, data: categories.rows });
    }

    async show(req, res) {
        const { uuids } = req.body;

        if (!uuids) {
            return res.sendStatus(HttpStatuses.BAD_REQUEST);
        }

        const array = uuids.split(', ');

        let uuid = [...new Set(array)];

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
