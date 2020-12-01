const bcrypt = require('bcryptjs');
const { Op } = require('sequelize');
const { Role } = require('../models');
class LoginHandler {
    constructor(userRepository, roleRepository) {
        this.userRepository = userRepository;
        this.roleRepository = roleRepository;
    }

    async handle(email, password) {
        const user = await this.userRepository.findOne({
            where: {
                email
            },
            attributes: ['id', 'email', 'password'],
            raw: true
        });

        if (!user) {
            return false;
        }

        const passwordIsValid = bcrypt.compareSync(password, user.password);

        if (!passwordIsValid) {
            return false;
        }

        const loggedUser = await this.userRepository.findByPk(user.id, {
            include: [
                {
                    association: 'roles',
                    through: { attributes: [] }
                }
            ]
        });

        return loggedUser;
    }

    async facebookHandle(facebookId, email, firstName, lastName) {
        let user = await this.userRepository.findOne({
            where: {
                [Op.or]: [{ email }, { facebookId }]
            }
        });

        if (!user) {
            const hash = Math.random().toString(36).slice(2);
            const password = bcrypt.hashSync(hash, 12);
            user = await this.userRepository.create({
                email,
                firstName,
                lastName,
                facebookId,
                password
            });

            const userRole = await this.roleRepository.findOne({
                where: {
                    name: Role.ROLE_EMPLOYEE
                }
            });

            await user.addRole(userRole);
        }

        if (!user.facebookId) {
            console.log(user);
            user = await user.update({ facebookId });
        }

        return user;
    }
}

module.exports = LoginHandler;
