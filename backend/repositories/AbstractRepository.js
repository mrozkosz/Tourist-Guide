class AbstractRepository {
    find(where, options = {}) {
        return typeof where === 'object'
            ? this.findOne(where, options)
            : this.findById(where, options);
    }

    findById(id, options = {}) {
        return this.model.findOne({
            where: {
                id
            },
            ...options
        });
    }

    findOne(where, options = {}) {
        return this.model.findOne({
            ...where,
            ...options
        });
    }

    findAll(where, options = {}) {
        return this.model.findAll({
            ...where,
            ...options
        });
    }

    findAndCountAll(where, options = {}) {
        return this.model.findAndCountAll({
            ...where,
            ...options
        });
    }

    count(where, options = {}) {
        return this.model.count({
            ...where,
            ...options
        });
    }

    updateById(id, data) {
        return this.model.update(data, {
            where: {
                id
            }
        });
    }

    destroy(where, options) {
        return this.model.destroy({
            ...where,
            ...options
        });
    }

    update(data, where = {}, options = {}) {
        return this.model.update(data, {
            ...where,
            ...options
        });
    }

    create(data, options) {
        return this.model.create(data, options);
    }

    bulkCreate(items = []) {
        return this.model.bulkCreate(items);
    }
}

module.exports = AbstractRepository;
