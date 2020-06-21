const HttpStatuses = require('http-status-codes');
const bcrypt = require('bcryptjs');
const config = require('../config');
const crypto = require('crypto');
const moment = require('moment');
const { Role } = require('../models');

class EmployeeController {
    constructor(
        sendEmailToNewUsersHandler,
        userRepository,
        recoverPasswordRepository,
        roleRepository
    ) {
        this.sendEmailToNewUsersHandler = sendEmailToNewUsersHandler;
        this.userRepository = userRepository;
        this.recoverPasswordRepository = recoverPasswordRepository;
        this.roleRepository = roleRepository;
    }

    async index(req, res) {
        const users = await this.userRepository.findAll();

        return res.send(users);
    }

    async create(req, res) {
        const hash = crypto.randomBytes(10).toString('hex');
        const { expiresIn } = config.password;
        const { password } = req.body;

        req.body.password = bcrypt.hashSync(password, 12);

        const user = await this.userRepository.create(req.body);

        const userRole = await this.roleRepository.findOne({
            where: {
                name: Role.ROLE_EMPLOYEE
            }
        });

        await user.addRole(userRole);

        const userCreated = await this.userRepository.findById(user.id);

        this.recoverPasswordRepository.create({
            userId: user.id,
            hash,
            expireIn: moment().add(expiresIn, 'ms')
        });

        this.sendEmailToNewUsersHandler.handle(userCreated, hash);

        return res.status(HttpStatuses.CREATED).send(userCreated);
    }

    async update(req, res) {
        const { id: userId } = req.params;

        const user = await this.userRepository.findById(userId);

        if (!user) {
            return res.sendStatus(HttpStatuses.NOT_FOUND);
        }

        const updatedUser = await user.update(req.body);

        return res.send(updatedUser);
    }

    async delete(req, res) {
        const userId = req.params.id;

        const user = await this.userRepository.findById(userId);

        if (!user) {
            return res.sendStatus(HttpStatuses.NO_CONTENT);
        }

        await this.recoverPasswordRepository.destroy({
            where: {
                userId: user.id
            }
        });

        await user.removeRoles(await user.getRoles());

        await user.destroy();

        return res.sendStatus(HttpStatuses.NO_CONTENT);
    }
}

module.exports = EmployeeController;
