const HttpStatuses = require('http-status-codes');

module.exports = async (req, res, next) => {
    const loggedUser = req.loggedUser;

    if (!loggedUser) {
        return res.sendStatus(HttpStatuses.UNAUTHORIZED);
    }

    const isAdmin = await req.loggedUser.isAdmin();

    if (!isAdmin) {
        req.isAdmin = false;
    } else {
        req.isAdmin = true;
    }

    return next();
};
