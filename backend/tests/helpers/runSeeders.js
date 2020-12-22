const { User, Role } = require('../../models');
const bcrypt = require('bcryptjs');

module.exports = async () => {
    let userRole = await Role.findOne({ where: { name: 'user' } });

    if (!userRole) {
        userRole = await Role.create({ name: 'user' });
    }

    let adminRole = await Role.findOne({ where: { name: 'admin' } });

    if (!userRole) {
        adminRole = await Role.create({ name: 'admin' });
    }

    const adminUser = await User.create({
        firstName: 'admin',
        lastName: 'admin',
        email: 'admin@estimoteapp.test',
        password: bcrypt.hashSync('password', 12)
    });

    await adminUser.addRole(adminRole);

    const user = await User.create({
        firstName: 'user',
        lastName: 'user',
        email: 'user@estimoteapp.test',
        password: bcrypt.hashSync('password', 12)
    });

    await user.addRole(userRole);
};
