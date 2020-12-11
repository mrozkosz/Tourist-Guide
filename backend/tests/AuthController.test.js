const HttpStatuses = require('http-status-codes');
const app = require('../app');
const request = require('supertest')(app);

const loginAsUser = require('./helpers/loginAsUser');
const loginAsAdmin = require('./helpers/loginAsAdmin');
const runSeeders = require('./helpers/runSeeders');
const recoverPasswordFactory = require('./factories/recoverPassword');

let loggedAsUser;
let loggedAsAdmin;

describe('AuthController', () => {
    beforeAll(async () => {
        try {
            await runSeeders();
        } catch (error) {}
        loggedAsUser = await loginAsUser(request);
        loggedAsAdmin = await loginAsAdmin(request);
    });

    describe('POST /login', () => {
        it('return error 400 when login with incorrect credentials', async (done) => {
            const { status, body } = await request
                .post(`/login`)
                .send({ email: 'mateusz@poczta.pl', password: 'xxxx' });

            expect(status).toEqual(HttpStatuses.BAD_REQUEST);
            expect(body).toHaveProperty('errors');
            expect(body.errors).toContainEqual({
                param: 'email',
                message: 'Email address does not exists!'
            });

            done();
        });

        it('return error 400 when email is empty', async (done) => {
            const { status, body } = await request
                .post(`/login`)
                .send({ email: '', password: 'xxxx' });

            expect(status).toEqual(HttpStatuses.BAD_REQUEST);
            expect(body).toHaveProperty('errors');
            expect(body.errors).toContainEqual({
                param: 'email',
                message: 'should be not empty'
            });

            done();
        });

        it('return error 401 when email is correct but password is incorrect', async (done) => {
            const { status } = await request
                .post(`/login`)
                .send({ email: 'admin@estimoteapp.test', password: 'xxxx' });

            expect(status).toEqual(HttpStatuses.UNAUTHORIZED);
            done();
        });
    });

    describe('POST /recover-password', () => {
        it('recover password with correct email', async (done) => {
            const { status } = await request
                .post(`/recover-password`)
                .send({ email: 'admin@estimoteapp.test' });

            expect(status).toEqual(HttpStatuses.NO_CONTENT);

            done();
        });
    });

    describe('POST /recover-password/{hash}', () => {
        it('return error 400 when email is incorrect', async (done) => {
            const { status, body } = await request.post(`/recover-password`);

            expect(body).toHaveProperty('errors');
            expect(status).toEqual(HttpStatuses.BAD_REQUEST);

            done();
        });

        it('return error 401 when recover hash is incorrect', async (done) => {
            const { status } = await request
                .post(`/recover-password/0d392898ecc8558c75e4`)
                .send({
                    email: 'admin@erpsystem.test',
                    password: 'ZAQ!2wsx',
                    passwordRepeat: 'ZAQ!2wsx'
                });

            expect(status).toEqual(HttpStatuses.UNAUTHORIZED);

            done();
        });

        it('return error 400 when the passwords do not match', async (done) => {
            const { user } = loggedAsAdmin.body;
            const { hash } = await recoverPasswordFactory.create({
                userId: user.id
            });
            const { status } = await request
                .post(`/recover-password/${hash}`)
                .send({
                    password: 'password',
                    passwordRepeat: 'password1'
                });

            expect(status).toEqual(HttpStatuses.BAD_REQUEST);

            done();
        });

        it('recover password as user', async (done) => {
            const { user } = loggedAsUser.body;
            const { hash } = await recoverPasswordFactory.create({
                userId: user.id
            });
            const { status } = await request
                .post(`/recover-password/${hash}`)
                .send({
                    password: 'password',
                    passwordRepeat: 'password'
                });

            expect(status).toEqual(HttpStatuses.NO_CONTENT);

            done();
        });

        it('recover password as admin', async (done) => {
            const { user } = loggedAsAdmin.body;
            const { hash } = await recoverPasswordFactory.create({
                userId: user.id
            });
            const { status } = await request
                .post(`/recover-password/${hash}`)
                .send({
                    password: 'password',
                    passwordRepeat: 'password'
                });

            expect(status).toEqual(HttpStatuses.NO_CONTENT);

            done();
        });
    });

    describe('GET /me', () => {
        it('return error 401 when token is incorrect', async (done) => {
            const { status } = await request.get(`/me`);

            expect(status).toEqual(HttpStatuses.UNAUTHORIZED);

            done();
        });

        it('return user detaild logged as user', async (done) => {
            const { token, user } = loggedAsUser.body;

            const { body } = await request
                .get(`/me`)
                .set('Authorization', 'Bearer ' + token);

            expect(body).toHaveProperty('email');
            expect(body.email).toEqual(user.email);

            done();
        });

        it('return user detaild logged as admin', async (done) => {
            const { token, user } = loggedAsAdmin.body;

            const { body } = await request
                .get(`/me`)
                .set('Authorization', 'Bearer ' + token);

            expect(body).toHaveProperty('email');
            expect(body.email).toEqual(user.email);

            done();
        });
    });
});
