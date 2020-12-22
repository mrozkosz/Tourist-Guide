const HttpStatuses = require('http-status-codes');
const { sequelize } = require('../models');
const { Op } = require('sequelize');

class HomeController {
    constructor(viewsRepository, pleaceRepository, categoryRepository) {
        this.viewsRepository = viewsRepository;
        this.pleaceRepository = pleaceRepository;
        this.categoryRepository = categoryRepository;
    }

    async index(req, res) {
        const limit = 5;
        const mostVisited = await this.viewsRepository.findAll({
            attributes: [
                'pleaceId',
                [sequelize.fn('sum', sequelize.col('views')), 'sumViews']
            ],
            group: ['pleaceId'],
            order: [[sequelize.literal('sumViews'), 'DESC']],
            limit,
            raw: true
        });

        const mostVisitedIds = mostVisited.map((item) => {
            return item.pleaceId;
        });

        const pleacesMostVisited = await this.pleaceRepository.findAll({
            where: {
                id: { [Op.in]: mostVisitedIds }
            },
            attributes: { exclude: ['description', 'lat', 'long'] }
        });

        let sortedPleaces = [];

        pleacesMostVisited.forEach(function (a) {
            sortedPleaces[mostVisitedIds.indexOf(a.id)] = a;
        });

        const categorie = await this.categoryRepository.findAll({
            limit: 10
        });

        const restPleaces = await this.pleaceRepository.findAll({
            where: {
                id: { [Op.notIn]: mostVisitedIds }
            },
            order: sequelize.literal('rand()'),
            limit: 10
        });

        return res.send({
            daily: {
                id: 1,
                location: 'Kraków',
                name: 'Rynek główny',
                coverImage: 'RGq0aLUVqP4boCk2.jpg'
            },
            mostVisited: sortedPleaces,
            categorie,
            restPleaces: restPleaces
        });
    }
}

module.exports = HomeController;
