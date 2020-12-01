const { Role } = require('../models');
const faker = require('faker');
const bcrypt = require('bcryptjs');

module.exports = {
    up: async (queryInterface, Sequelize) => {
        const di = require('../di');
        const userRepository = di.get('repositories.user');
        const roleRepository = di.get('repositories.role');

        const adminRole = await roleRepository.findOne({
            where: {
                name: Role.ADMIN
            }
        });

        const userRole = await roleRepository.findOne({
            where: {
                name: Role.USER
            }
        });

        await queryInterface.bulkInsert(
            'Users',
            [
                {
                    firstName: faker.name.firstName(),
                    lastName: 'Admin',
                    email: 'admin@wp.pl',
                    password: bcrypt.hashSync('password', 12)
                },
                {
                    firstName: faker.name.firstName(),
                    lastName: 'User',
                    email: 'user@wp.pl',
                    password: bcrypt.hashSync('password', 12)
                }
            ],
            {}
        );

        const admin = await userRepository.findOne({
            where: {
                lastName: 'Admin'
            }
        });

        await admin.setRoles([adminRole]);

        const user = await userRepository.findOne({
            where: {
                lastName: 'User'
            }
        });

        await user.setRoles([userRole]);
    },

    down: (queryInterface, Sequelize) => {}
};
