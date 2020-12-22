const HttpStatuses = require('http-status-codes');
const { Op, sequelize } = require('sequelize');
const config = require('../config');
const mime = require('mime-types');
const sharp = require('sharp');

class PleaceController {
    constructor(pleaceRepository, pleaceCategoryRepository, viewsRepository) {
        this.pleaceRepository = pleaceRepository;
        this.pleaceCategoryRepository = pleaceCategoryRepository;
        this.viewsRepository = viewsRepository;
    }

    async index(req, res) {
        const {
            perPage = 5,
            page = 1,
            sortBy = 'createdAt',
            order = 'desc'
        } = req.query;

        const { q } = req.query;

        const pageNumber = parseInt(page);
        const limit = parseInt(perPage);

        const offset = (pageNumber - 1) * limit;

        let where = {};

        if (q) {
            where = {
                [Op.or]: [
                    {
                        name: {
                            [Op.like]: `%${q}%`
                        }
                    },
                    {
                        location: {
                            [Op.like]: `%${q}%`
                        }
                    },
                    {
                        description: {
                            [Op.like]: `%${q}%`
                        }
                    }
                ]
            };
        }

        const categories = await this.pleaceRepository.findAndCountAll({
            where,
            offset,
            limit,
            order: [[sortBy, order]]
        });

        const totalPages = Math.ceil(categories.count / limit);

        return res.send({ totalPages, data: categories.rows });
    }

    async show(req, res) {
        const { id } = req.params;
        const { id: userId } = req.loggedUser;
        const { ip } = req;

        const pleace = await this.pleaceRepository.findOne({
            where: { id },
            include: [
                {
                    association: 'photos'
                },
                {
                    association: 'tracks'
                }
            ],
            rows: false
        });

        if (!pleace) {
            return res.sendStatus(HttpStatuses.NOT_FOUND);
        }

        const { id: pleaceId } = pleace;

        const view = await this.viewsRepository.findOne({
            where: {
                pleaceId,
                userId,
                ip
            }
        });

        if (!view) {
            await this.viewsRepository.create({
                pleaceId,
                userId,
                ip,
                views: 1
            });
        } else {
            view.increment('views', { by: 1 });
        }

        return res.send({ results: pleace });
    }

    async update(req, res) {
        const { id } = req.params;

        const pleace = await this.pleaceRepository.findById(id);

        if (!pleace) {
            return res.sendStatus(HttpStatuses.NOT_FOUND);
        }

        pleace.update({ ...req.body });

        return res.send(pleace);
    }

    async delete(req, res) {
        const { id } = req.params;

        await this.pleaceRepository.destroy({ where: { id } });

        return res.sendStatus(HttpStatuses.NO_CONTENT);
    }

    makeid(length) {
        var result = '';
        var characters =
            'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
        var charactersLength = characters.length;
        for (var i = 0; i < length; i++) {
            result += characters.charAt(
                Math.floor(Math.random() * charactersLength)
            );
        }
        return result;
    }

    async create(req, res) {
        const { versions, path } = config.imagerResizer;
        const { categorieId } = req.body;

        if (!req.files) {
            return res.status(400).send('No files were uploaded.');
        }

        const { image } = req.files;
        const fileExtension = mime.extension(image.mimetype);
        const fileName = this.makeid(15) + '.' + fileExtension;

        if (image.size >= 9506136) {
            return res.send('Image is to big' + image.size);
        }

        versions.map((size) => {
            sharp(image.data)
                .resize({ width: size })
                .toFile(`${path}/s${size}/${fileName}`);
        });

        req.body.coverImage = fileName;

        const pleace = await this.pleaceRepository.create(req.body);

        this.pleaceCategoryRepository.create({
            pleaceId: pleace.id,
            categorieId
        });

        return res.send(pleace);
    }
}

module.exports = PleaceController;
