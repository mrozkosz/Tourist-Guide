const AbstractRepository = require('./AbstractRepository');
const { Comment } = require('../models');

class CommentRepository extends AbstractRepository {
    get model() {
        return Comment;
    }
}

module.exports = CommentRepository;
