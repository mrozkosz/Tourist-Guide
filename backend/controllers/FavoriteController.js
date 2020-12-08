const HttpStatuses = require('http-status-codes');
const { Op } = require('sequelize');
const config = require('../config');

class FavoriteController {
    constructor(favoriteRepository, pleaceRepository) {
        this.favoriteRepository = favoriteRepository;
        this.pleaceRepository = pleaceRepository;
    }

    async index(req, res) {
        const {
            perPage = 5,
            page = 1,
            sortBy = 'createdAt',
            order = 'desc'
        } = req.query;
        const { loggedUser } = req;

        const pageNumber = parseInt(page);
        const limit = parseInt(perPage);

        const offset = (pageNumber - 1) * limit;

        let where = { isFavorite: 1, userId: loggedUser.id };

        const favorites = await this.favoriteRepository.findAndCountAll({
            where,
            include: [
                {
                    association: 'pleace'
                }
            ],
            offset,
            limit,
            order: [[sortBy, order]]
        });

        const totalPages = Math.ceil(favorites.count / limit);

        return res.send({ totalPages, data: favorites.rows });
    }

    async show(req, res) {
        const { id } = req.params;
        const { loggedUser } = req;

        const favorite = await this.favoriteRepository.findOne({
            where: { pleaceId: id, userId: loggedUser.id }
        });

        if (!favorite) {
            return res.send({ isFavorite: false });
        }

        const { isFavorite } = favorite;

        return res.send({ isFavorite });
    }

    async createOrUpdate(req, res) {
        const { id } = req.params;
        const { loggedUser } = req;

        const pleace = await this.pleaceRepository.findById(id);

        if (!pleace) {
            return res.sendStatus(HttpStatuses.NOT_FOUND);
        }

        const favorite = await this.favoriteRepository.findOne({
            where: { pleaceId: id, userId: loggedUser.id }
        });

        if (!favorite) {
            const createdFavorite = await this.favoriteRepository.create({
                userId: loggedUser.id,
                pleaceId: id,
                isFavorite: 1
            });

            const { isFavorite } = createdFavorite;

            return res.send({ isFavorite });
        }

        favorite.update({ isFavorite: !favorite.isFavorite });

        const { isFavorite } = favorite;

        return res.send({ isFavorite });
    }
}

module.exports = FavoriteController;
