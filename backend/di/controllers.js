const { Reference } = require('node-dependency-injection');
const AuthController = require('../controllers/AuthController');
const BeaconController = require('../controllers/BeaconController');
const CategoryController = require('../controllers/CategoryController');
const PleaceController = require('../controllers/PleaceController');
const CommentController = require('../controllers/CommentController');
const FavoriteController = require('../controllers/FavoriteController');
const UsersController = require('../controllers/UsersController');
const HomeController = require('../controllers/HomeController');
const PhotoController = require('../controllers/PhotoController');

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
        .addArgument(new Reference('repositories.pleaceCategory'))
        .addArgument(new Reference('repositories.view'));

    container
        .register('controller.comment', CommentController)
        .addArgument(new Reference('repositories.comment'))
        .addArgument(new Reference('repositories.pleace'));

    container
        .register('controller.favorite', FavoriteController)
        .addArgument(new Reference('repositories.favorite'))
        .addArgument(new Reference('repositories.pleace'));

    container
        .register('controller.user', UsersController)
        .addArgument(new Reference('repositories.user'))
        .addArgument(new Reference('repositories.role'));

    container
        .register('controller.home', HomeController)
        .addArgument(new Reference('repositories.view'))
        .addArgument(new Reference('repositories.pleace'))
        .addArgument(new Reference('repositories.category'));

    container
        .register('controller.photo', PhotoController)
        .addArgument(new Reference('repositories.photo'));
};
