const { Reference } = require('node-dependency-injection');
const AuthController = require('../controllers/AuthController');
const BeaconController = require('../controllers/BeaconController');
const CategoryController = require('../controllers/CategoryController');
const PleaceController = require('../controllers/PleaceController');
const CommentController = require('../controllers/CommentController');
const FavoriteController = require('../controllers/FavoriteController');

module.exports = (container) => {
    container
        .register('controller.auth', AuthController)
        .addArgument(new Reference('services.loginHandler'))
        .addArgument(
            new Reference('services.sendEmailToRecoverPasswordHandler')
        )
        .addArgument(new Reference('repositories.recoverPassword'))
        .addArgument(new Reference('repositories.refreshToken'));

    container
        .register('controller.beacon', BeaconController)
        .addArgument(new Reference('repositories.beacon'))
        .addArgument(new Reference('repositories.pleace'));

    container
        .register('controller.category', CategoryController)
        .addArgument(new Reference('repositories.category'))
        .addArgument(new Reference('repositories.pleaceCategory'))
        .addArgument(new Reference('repositories.pleace'));

    container
        .register('controller.pleace', PleaceController)
        .addArgument(new Reference('repositories.pleace'))
        .addArgument(new Reference('repositories.pleaceCategory'));

    container
        .register('controller.comment', CommentController)
        .addArgument(new Reference('repositories.comment'))
        .addArgument(new Reference('repositories.pleace'));

    container
        .register('controller.favorite', FavoriteController)
        .addArgument(new Reference('repositories.favorite'))
        .addArgument(new Reference('repositories.pleace'));
};
