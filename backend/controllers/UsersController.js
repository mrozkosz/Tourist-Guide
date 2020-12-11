const HttpStatuses = require('http-status-codes');
const { Role } = require('../models');
const bcrypt = require('bcryptjs');

class UsersController {
    constructor(userRepository, roleRepository) {
        this.userRepository = userRepository;
        this.roleRepository = roleRepository;
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

        const users = await this.userRepository.findAndCountAll({
            where,
            offset,
            limit,
            order: [[sortBy, order]]
        });

        const totalPages = Math.ceil(users.count / limit);

        return res.send({ totalPages, data: users.rows });
    }

    async show(req, res) {
        const { id } = req.params;
        const { isAdmin, loggedUser } = req;

        if (!isAdmin && loggedUser.id != id) {
            return res.sendStatus(HttpStatuses.FORBIDDEN);
        }

        const user = await this.userRepository.get(id);

        if (!user) {
            return res.sendStatus(HttpStatuses.NOT_FOUND);
        }

        return res.send(user);
    }

    async update(req, res) {
        const { id } = req.params;
        const user = await this.userRepository.findOne({
            where: { id }
        });

        if (!user) {
            return res.sendStatus(HttpStatuses.NOT_FOUND);
        }

        await user.update(req.body);

        const userUpdated = await this.userRepository.get(user.id);

        return res.send(userUpdated);
    }

    async create(req, res) {
        const { password } = req.body;

        req.body.password = bcrypt.hashSync(password, 12);

        const user = await this.userRepository.create({ ...req.body });

        const userRole = await this.roleRepository.findOne({
            where: {
                name: Role.USER
            }
        });

        await user.setRoles([userRole]);

        const userCreated = await this.userRepository.get(user.id);

        return res.status(HttpStatuses.CREATED).send(userCreated);
    }

    async delete(req, res) {
        const { id } = req.params;
        const user = await this.userRepository.findById(id);

        if (!user) {
            return res.sendStatus(HttpStatuses.NO_CONTENT);
        }

        await user.removeRoles(await user.getRoles());
        await user.destroy();

        return res.sendStatus(HttpStatuses.NO_CONTENT);
    }
}

module.exports = UsersController;
