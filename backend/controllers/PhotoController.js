const HttpStatuses = require('http-status-codes');
const config = require('../config');
const mime = require('mime-types');
const sharp = require('sharp');

class PhotoController {
    constructor(photoRepository) {
        this.photoRepository = photoRepository;
    }

    async index(req, res) {
        const {
            perPage = 5,
            page = 1,
            sortBy = 'createdAt',
            order = 'desc',
            pleaceId = null
        } = req.query;

        const pageNumber = parseInt(page);
        const limit = parseInt(perPage);

        const offset = (pageNumber - 1) * limit;

        let where = {};

        if (pleaceId) {
            where = {
                pleaceId
            };
        }

        const photos = await this.photoRepository.findAndCountAll({
            where,
            offset,
            limit,
            order: [[sortBy, order]]
        });

        const totalPages = Math.ceil(photos.count / limit);

        return res.send({ totalPages, data: photos.rows });
    }

    async show(req, res) {
        const { id } = req.params;

        const photo = await this.photoRepository.findOne({
            where: { id },
            rows: false
        });

        if (!photo) {
            return res.sendStatus(HttpStatuses.NOT_FOUND);
        }

        return res.send({ results: photo });
    }

    async delete(req, res) {
        const { id } = req.params;

        await this.photoRepository.destroy({ where: { id } });

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
        const { id } = req.params;

        if (!req.files) {
            return res.status(400).send('No files were uploaded.');
        }

        const { images: files } = req.files;

        if (files.data) {
            const fileExtension = mime.extension(files.mimetype);
            const fileName = this.makeid(15) + '.' + fileExtension;

            if (files.size >= 9506136) {
                return res.send('Image is to big' + files.size);
            }

            versions.map((size) => {
                sharp(files.data)
                    .resize({ width: size })
                    .toFile(`${path}/s${size}/${fileName}`);
            });

            const img = await this.photoRepository.create({
                pleaceId: id,
                url: fileName,
                description: files.name
            });
        } else {
            files.map(async (image) => {
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

                const img = await this.photoRepository.create({
                    pleaceId: id,
                    url: fileName,
                    description: image.name
                });
            });
        }

        return res.sendStatus(HttpStatuses.CREATED);
    }
}

module.exports = PhotoController;
