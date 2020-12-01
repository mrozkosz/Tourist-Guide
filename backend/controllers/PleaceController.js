const HttpStatuses = require('http-status-codes');
const { Op } = require('sequelize');
const config = require('../config');
const mime = require('mime-types');
const sharp = require('sharp');

class PleaceController {
    constructor(pleaceRepository, pleaceCategoryRepository) {
        this.pleaceRepository = pleaceRepository;
        this.pleaceCategoryRepository = pleaceCategoryRepository;
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

        return res.send({ results: pleace });
    }

    async update(req, res) {
        const { id } = req.params;
        const { name } = req.body;

        const pleace = await this.pleaceRepository.findById(id);

        if (!pleace) {
            return res.sendStatus(HttpStatuses.NOT_FOUND);
        }

        pleace.update({ name });

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

    async test(req, res) {
        console.log('working');
        return res.send({
            daily: {
                id: 6,
                location: 'Kraków',
                name: 'Rynek główny',
                description: 'fe',
                coverImage: 'RGq0aLUVqP4boCk2.jpg'
            },
            mostVisited: [
                {
                    id: 1,
                    location: 'Kraków',
                    name: 'Sukiennice',
                    description: 'xxxx',
                    coverImage: 'RGq0aLUVqP4boCk.jpeg'
                },
                {
                    id: 2,
                    location: 'Wrocław',
                    name: 'Panorama Racławicka',
                    description: 'zzzzz',
                    coverImage: 'wroclaw.jpg'
                }
            ],
            categorie: [
                {
                    id: 1,
                    name: 'Miasta'
                },
                {
                    id: 2,
                    name: 'Zabytki'
                },
                {
                    id: 3,
                    name: 'Zbiorniki wodne'
                }
            ]
        });
    }
}

module.exports = PleaceController;
