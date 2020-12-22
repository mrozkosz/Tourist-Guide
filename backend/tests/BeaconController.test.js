const HttpStatuses = require('http-status-codes');
const app = require('../app');
const request = require('supertest')(app);

const loginAsUser = require('./helpers/loginAsUser');
const loginAsAdmin = require('./helpers/loginAsAdmin');
const runSeeders = require('./helpers/runSeeders');
const PleaceFactory = require('./factories/pleace');
const BeaconFactory = require('./factories/beacon');

let loggedAsUser;
let loggedAsAdmin;
let pleace;
let beacon;

describe('BeaconController', () => {
    beforeAll(async () => {
        try {
            await runSeeders();
        } catch (error) {}

        loggedAsUser = await loginAsUser(request);
        loggedAsAdmin = await loginAsAdmin(request);
        pleace = await PleaceFactory.create();
        beacon = await BeaconFactory.create({ pleaceId: pleace.id });
    });

    describe('POST /beacons/detected', () => {
        it('get all selected beacons as admin', async (done) => {
            const { token } = loggedAsAdmin.body;

            const { status, body } = await request
                .post(`/beacons/detected`)
                .set('Authorization', 'Bearer ' + token)
                .send({ uuids: beacon.uuid });

            expect(status).toEqual(HttpStatuses.OK);
            done();
        });

        it('get all selected beacons as user', async (done) => {
            const { token } = loggedAsUser.body;

            const { status, body } = await request
                .post(`/beacons/detected`)
                .set('Authorization', 'Bearer ' + token)
                .send({ uuids: beacon.uuid });

            expect(status).toEqual(HttpStatuses.OK);
            done();
        });

        it("return error 400 when uuids is't set", async (done) => {
            const { token } = loggedAsAdmin.body;

            const { status } = await request
                .post(`/beacons/detected`)
                .set('Authorization', 'Bearer ' + token);

            expect(status).toEqual(HttpStatuses.BAD_REQUEST);
            done();
        });

        it('return error 401 when token is incorrect', async (done) => {
            const { token } = loggedAsAdmin.body;

            const { status } = await request.post(`/beacons/detected`);

            expect(status).toEqual(HttpStatuses.UNAUTHORIZED);
            done();
        });
    });

    describe('POST /beacons', () => {
        it('create beacon as admin', async (done) => {
            const { token } = loggedAsAdmin.body;
            const beaconParams = await BeaconFactory.generate({
                pleaceId: pleace.id
            });

            const { status } = await request
                .post(`/beacons`)
                .set('Authorization', 'Bearer ' + token)
                .send(beaconParams);

            expect(status).toEqual(HttpStatuses.CREATED);

            done();
        });

        it('return error 400 when create beacon as admin without pleaceId', async (done) => {
            const { token } = loggedAsAdmin.body;
            const beaconParams = await BeaconFactory.generate({
                pleaceId: null
            });

            const { status, body } = await request
                .post(`/beacons`)
                .set('Authorization', 'Bearer ' + token)
                .send(beaconParams);

            expect(status).toEqual(HttpStatuses.BAD_REQUEST);
            expect(body).toHaveProperty('errors');
            expect(body.errors).toContainEqual({
                param: 'pleaceId',
                message: 'should be not empty'
            });

            done();
        });

        it('return 401 when create beacon as user', async (done) => {
            const { token } = loggedAsUser.body;

            const { status } = await request.post(`/beacons`);

            expect(status).toEqual(HttpStatuses.UNAUTHORIZED);
            done();
        });
    });

    describe('GET /beacons', () => {
        it('return error 401 when token is incorrect', async (done) => {
            const { status } = await request.get(`/beacons`);

            expect(status).toEqual(HttpStatuses.UNAUTHORIZED);

            done();
        });

        it('return error 403 when logged as user', async (done) => {
            const { token, user } = loggedAsUser.body;

            const { status } = await request
                .get(`/beacons`)
                .set('Authorization', 'Bearer ' + token);

            expect(status).toEqual(HttpStatuses.FORBIDDEN);

            done();
        });

        it('return beacons detaild logged as admin', async (done) => {
            const { token, user } = loggedAsAdmin.body;

            const { status } = await request
                .get(`/beacons`)
                .set('Authorization', 'Bearer ' + token);

            expect(status).toEqual(HttpStatuses.OK);

            done();
        });
    });

    describe('DELETE /beacons/{id}', () => {
        it('return error 403 when delete as user', async (done) => {
            const { token } = loggedAsUser.body;

            const { status } = await request
                .delete(`/beacons/${beacon.id}`)
                .set('Authorization', 'Bearer ' + token);

            expect(status).toEqual(HttpStatuses.FORBIDDEN);

            done();
        });

        it('return error 204 when contract does not exist as admin', async (done) => {
            const { token } = loggedAsAdmin.body;

            const { status } = await request
                .delete(`/beacons/9999999999999`)
                .set('Authorization', 'Bearer ' + token);

            expect(status).toEqual(HttpStatuses.NO_CONTENT);

            done();
        });

        it('return 204 when delete contract as admin', async (done) => {
            const { token } = loggedAsAdmin.body;

            const { status } = await request
                .delete(`/beacons/${beacon.id}`)
                .set('Authorization', 'Bearer ' + token);

            expect(status).toEqual(HttpStatuses.NO_CONTENT);

            done();
        });

        it('return error 401 when unauthorized', async (done) => {
            const { status } = await request.delete(`/beacons/${beacon.id}`);

            expect(status).toEqual(HttpStatuses.UNAUTHORIZED);

            done();
        });
    });
});
