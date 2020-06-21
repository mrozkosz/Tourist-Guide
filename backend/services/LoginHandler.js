const bcrypt = require('bcryptjs');

class LoginHandler {
    constructor(userRepository) {
        this.userRepository = userRepository;
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
}

module.exports = LoginHandler;
