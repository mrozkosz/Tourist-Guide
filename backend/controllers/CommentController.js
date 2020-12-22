class CommentController {
    constructor(commentRepository, pleaceRepository) {
        this.commentRepository = commentRepository;
        this.pleaceRepository = pleaceRepository;
    }

    async show(id) {
        const perPage = 150,
            page = 1,
            sortBy = 'createdAt',
            order = 'asc';

        const pageNumber = parseInt(page);
        const limit = parseInt(perPage);

        const offset = (pageNumber - 1) * limit;

        let where = {
            pleaceId: id
        };

        const comments = await this.commentRepository.findAndCountAll({
            where,
            include: [
                {
                    association: 'user'
                }
            ],
            offset,
            limit,
            order: [[sortBy, order]]
        });

        if (!comments) {
            return false;
        }

        return comments;
    }

    async create(pleaceId, msg, userId) {
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
