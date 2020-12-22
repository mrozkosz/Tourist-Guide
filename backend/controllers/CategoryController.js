const HttpStatuses = require('http-status-codes');

class CategoryController {
    constructor(
        categoryRepository,
        pleaceCategoryRepository,
        pleaceRepository
    ) {
        this.categoryRepository = categoryRepository;
        this.pleaceCategoryRepository = pleaceCategoryRepository;
        this.pleaceRepository = pleaceRepository;
    }

    async index(req, res) {
        const {
            perPage = 5,
            page = 1,
            sortBy = 'createdAt',
            order = 'desc',
            all = false
        } = req.query;

        if (all) {
            const categories = await this.categoryRepository.findAndCountAll();

            return res.send({ totalPages: 1, data: categories.rows });
        }

        const pageNumber = parseInt(page);
        const limit = parseInt(perPage);

        const offset = (pageNumber - 1) * limit;

        const where = {};

        const categories = await this.categoryRepository.findAndCountAll({
            where,
            offset,
            limit,
            order: [[sortBy, order]]
        });

        const totalPages = Math.ceil(categories.count / limit);

        return res.send({ totalPages, data: categories.rows });
    }

    async show(req, res) {
        const { id: categorieId } = req.params;

        const pleaces = await this.pleaceCategoryRepository.findAll({
            where: { categorieId },

            include: [
                {
                    association: 'pleace'
                }
            ],
            rows: false
        });

        if (!pleaces.length) {
            return res.sendStatus(HttpStatuses.NOT_FOUND);
        }

        return res.send(pleaces);
    }

    async update(req, res) {
        const { id } = req.params;
        const { name } = req.body;

        const category = await this.categoryRepository.findById(id);

        if (!category) {
            return res.sendStatus(HttpStatuses.NOT_FOUND);
        }

        category.update({ name });

        return res.send(category);
    }

    async delete(req, res) {
        const { id } = req.params;

        await this.categoryRepository.destroy({ where: { id } });

        return res.sendStatus(HttpStatuses.NO_CONTENT);
    }

    async create(req, res) {
        const { name } = req.body;

        const category = await this.categoryRepository.findOne({
            where: { name }
        });

        if (category) {
            return res.sendStatus(HttpStatuses.NO_CONTENT);
        }

        await this.categoryRepository.create(req.body);

        return res.sendStatus(HttpStatuses.CREATED);
    }
}

module.exports = CategoryController;
