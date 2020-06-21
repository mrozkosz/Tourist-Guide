const HttpStatuses = require('http-status-codes');

module.exports = async (req, res, next) => {
    const loggedUser = req.loggedUser;

    if (!loggedUser) {
        return res.sendStatus(HttpStatuses.UNAUTHORIZED);
    }

    req.isAdmin = !(await req.loggedUser.isEmployee());

    return next();
};
