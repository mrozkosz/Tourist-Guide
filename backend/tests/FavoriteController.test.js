const HttpStatuses = require('http-status-codes');
const app = require('../app');
const request = require('supertest')(app);

const loginAsUser = require('./helpers/loginAsUser');
const loginAsAdmin = require('./helpers/loginAsAdmin');
const runSeeders = require('./helpers/runSeeders');
const PleaceFactory = require('./factories/pleace');

let loggedAsUser;
let loggedAsAdmin;
let pleace;

describe('CategoryController', () => {
    beforeAll(async () => {
        try {
            await runSeeders();
        } catch (error) {}

        loggedAsUser = await loginAsUser(request);
        loggedAsAdmin = await loginAsAdmin(request);
        pleace = await PleaceFactory.create();
    });

    describe('PUT /favorites/id', () => {
        it('set as favorite pleace as admin', async (done) => {
            const { token } = loggedAsAdmin.body;

            const { status } = await request
                .put(`/favorites/${pleace.id}`)
                .set('Authorization', 'Bearer ' + token);

            expect(status).toEqual(HttpStatuses.OK);

            done();
        });

        it('set as favorite pleace as user', async (done) => {
            const { token } = loggedAsUser.body;

            const { status } = await request
                .put(`/favorites/${pleace.id}`)
                .set('Authorization', 'Bearer ' + token);

            expect(status).toEqual(HttpStatuses.OK);

            done();
        });
    });

    describe('GET /favorites', () => {
        it('get all favorite pleaces as admin', async (done) => {
            const { token } = loggedAsAdmin.body;

            const { status } = await request
                .get(`/favorites`)
                .set('Authorization', 'Bearer ' + token);

            expect(status).toEqual(HttpStatuses.OK);

            done();
        });

        it('get all favorite pleaces as user', async (done) => {
            const { token } = loggedAsUser.body;

            const { status } = await request
                .get(`/favorites`)
                .set('Authorization', 'Bearer ' + token);

            expect(status).toEqual(HttpStatuses.OK);

            done();
        });
    });

    describe('GET /favorites/id', () => {
        it('get data as admin', async (done) => {
            const { token } = loggedAsAdmin.body;

            const { status } = await request
                .get(`/favorites/${pleace.id}`)
                .set('Authorization', 'Bearer ' + token);

            expect(status).toEqual(HttpStatuses.OK);

            done();
        });

        it('get data as user', async (done) => {
            const { token } = loggedAsUser.body;

            const { status } = await request
                .get(`/favorites/${pleace.id}`)
                .set('Authorization', 'Bearer ' + token);

            expect(status).toEqual(HttpStatuses.OK);

            done();
        });

        it('return 404 if trying to find non-existent favorite pleace as admin', async (done) => {
            const { token } = loggedAsAdmin.body;

            const { status } = await request
                .get(`/favorites/99999999999999`)
                .set('Authorization', 'Bearer ' + token);

            expect(status).toEqual(HttpStatuses.NOT_FOUND);

            done();
        });

        it('return 404 if trying to find non-existent favorite pleace as user', async (done) => {
            const { token } = loggedAsUser.body;

            const { status } = await request
                .get(`/favorites/99999999999999`)
                .set('Authorization', 'Bearer ' + token);

            expect(status).toEqual(HttpStatuses.NOT_FOUND);

            done();
        });
    });
});
