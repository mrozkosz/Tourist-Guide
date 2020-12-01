class CommentController {
    constructor(commentRepository, pleaceRepository) {
        this.commentRepository = commentRepository;
        this.pleaceRepository = pleaceRepository;
    }

    async show(id) {
        const comments = await this.commentRepository.findAll({
            where: { pleaceId: id },
            include: [
                {
                    association: 'user'
                }
            ],

            rows: false
        });

        if (!comments) {
            return false;
        }

        return comments;
    }

    async create(pardedMessage, userId) {
        const { join: pleaceId, msg } = pardedMessage;

        const pleace = await this.pleaceRepository.findOne({
            where: { id: pleaceId }
        });

        if (!pleace) {
            return;
        }

        const createdComment = await this.commentRepository.create({
            pleaceId,
            message: msg,
            userId
        });

        return createdComment;
    }
}

module.exports = CommentController;
