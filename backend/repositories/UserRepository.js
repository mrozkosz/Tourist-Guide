const AbstractRepository = require('./AbstractRepository');
const { User } = require('../models');

class UserRepository extends AbstractRepository {
    get model() {
        return User;
    }

    async getAll() {
        return await this.findAll({
            include: [
                {
                    association: 'Roles',
                    through: {
                        attributes: []
                    }
                }
            ]
        });
    }

    async get(id) {
        const user = await this.findById(id, {
            include: [
                {
                    association: 'Roles',
                    through: {
                        attributes: []
                    }
                }
            ],
            subQuery: false
        });

        if (!user) {
            return null;
        }

        return user;
    }

    async findByEmail(email) {
        return await this.findOne({
            where: {
                email
            }
        });
    }
}

module.exports = UserRepository;
