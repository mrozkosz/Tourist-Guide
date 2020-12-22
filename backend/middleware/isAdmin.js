const HttpStatuses = require('http-status-codes');

module.exports = async (req, res, next) => {
    const loggedUser = req.loggedUser;

    if (!loggedUser) {
        return res.sendStatus(HttpStatuses.UNAUTHORIZED);
    }

    const isAdmin = await req.loggedUser.isAdmin();

    if (!isAdmin) {
        return res.status(HttpStatuses.FORBIDDEN).send({
            message: 'You must be the admin user'
        });
    }

    req.isAdmin = true;

    return next();
};
