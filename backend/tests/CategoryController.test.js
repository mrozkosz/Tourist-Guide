const HttpStatuses = require('http-status-codes');
const app = require('../app');
const request = require('supertest')(app);

const loginAsUser = require('./helpers/loginAsUser');
const loginAsAdmin = require('./helpers/loginAsAdmin');
const runSeeders = require('./helpers/runSeeders');
const PleaceFactory = require('./factories/pleace');
const CategoryFactory = require('./factories/category');

let loggedAsUser;
let loggedAsAdmin;
let pleace;
let category;

describe('CategoryController', () => {
    beforeAll(async () => {
        try {
            await runSeeders();
        } catch (error) {}

        loggedAsUser = await loginAsUser(request);
        loggedAsAdmin = await loginAsAdmin(request);
        pleace = await PleaceFactory.create();
        category = await CategoryFactory.create();
    });

    describe('POST /category', () => {
        it('create category as admin', async (done) => {
            const { token } = loggedAsAdmin.body;
            const categoryParams = await CategoryFactory.generate();

            const { status, body } = await request
                .post(`/category`)
                .set('Authorization', 'Bearer ' + token)
                .send(categoryParams);

            expect(status).toEqual(HttpStatuses.CREATED);
            done();
        });

        it('return error 400 when param is empty as admin', async (done) => {
            const { token } = loggedAsAdmin.body;

            const { status } = await request
                .post(`/category`)
                .set('Authorization', 'Bearer ' + token);

            expect(status).toEqual(HttpStatuses.BAD_REQUEST);
            done();
        });

        it('return error 403 when param is empty as user', async (done) => {
            const { token } = loggedAsUser.body;

            const { status } = await request
                .post(`/category`)
                .set('Authorization', 'Bearer ' + token);

            expect(status).toEqual(HttpStatuses.FORBIDDEN);
            done();
        });

        it('return error 401 when token is incorrect', async (done) => {
            const { token } = loggedAsAdmin.body;

            const { status } = await request.post(`/category`);

            expect(status).toEqual(HttpStatuses.UNAUTHORIZED);
            done();
        });
    });

    describe('PUT /category', () => {
        it('update category as admin', async (done) => {
            const { token } = loggedAsAdmin.body;
            const categoryParams = await CategoryFactory.generate();

            const { status } = await request
                .put(`/category/${category.id}`)
                .set('Authorization', 'Bearer ' + token)
                .send(categoryParams);

            expect(status).toEqual(HttpStatuses.OK);

            done();
        });

        it('return error 403 when update category as user', async (done) => {
            const { token } = loggedAsUser.body;

            const categoryParams = await CategoryFactory.generate();

            const { status } = await request
                .put(`/category/${category.id}`)
                .set('Authorization', 'Bearer ' + token)
                .send(categoryParams);

            expect(status).toEqual(HttpStatuses.FORBIDDEN);

            done();
        });
    });

    describe('GET /category', () => {
        it('get all category as admin', async (done) => {
            const { token } = loggedAsAdmin.body;

            const { status } = await request
                .get(`/category`)
                .set('Authorization', 'Bearer ' + token);

            expect(status).toEqual(HttpStatuses.OK);

            done();
        });

        it('get all category as user', async (done) => {
            const { token } = loggedAsUser.body;

            const { status } = await request
                .get(`/category`)
                .set('Authorization', 'Bearer ' + token);

            expect(status).toEqual(HttpStatuses.OK);

            done();
        });
    });

    describe('GET /category/id', () => {
        it('return 404 if trying to find non-existent contract as admin', async (done) => {
            const { token } = loggedAsAdmin.body;

            const { status } = await request
                .get(`/category/99999999999999`)
                .set('Authorization', 'Bearer ' + token);

            expect(status).toEqual(HttpStatuses.NOT_FOUND);

            done();
        });

        it('return 404 if trying to find non-existent contract as user', async (done) => {
            const { token } = loggedAsUser.body;

            const { status } = await request
                .get(`/category/99999999999999`)
                .set('Authorization', 'Bearer ' + token);

            expect(status).toEqual(HttpStatuses.NOT_FOUND);

            done();
        });
    });

    describe('DELETE /category/{id}', () => {
        it('return error 403 when delete as user', async (done) => {
            const { token } = loggedAsUser.body;

            const { status } = await request
                .delete(`/category/${category.id}`)
                .set('Authorization', 'Bearer ' + token);

            expect(status).toEqual(HttpStatuses.FORBIDDEN);

            done();
        });

        it('return error 204 when contract does not exist as admin', async (done) => {
            const { token } = loggedAsAdmin.body;

            const { status } = await request
                .delete(`/category/9999999999999`)
                .set('Authorization', 'Bearer ' + token);

            expect(status).toEqual(HttpStatuses.NO_CONTENT);

            done();
        });

        it('return 204 when delete contract as admin', async (done) => {
            const { token } = loggedAsAdmin.body;

            const { status } = await request
                .delete(`/category/${category.id}`)
                .set('Authorization', 'Bearer ' + token);

            expect(status).toEqual(HttpStatuses.NO_CONTENT);

            done();
        });

        it('return error 401 when unauthorized', async (done) => {
            const { status } = await request.delete(`/category/${category.id}`);

            expect(status).toEqual(HttpStatuses.UNAUTHORIZED);

            done();
        });
    });
});
