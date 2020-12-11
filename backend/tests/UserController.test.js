const HttpStatuses = require('http-status-codes');
const app = require('../app');
const request = require('supertest')(app);

const loginAsAdmin = require('./helpers/loginAsAdmin');
const loginAsUser = require('./helpers/loginAsUser');
const runSeeders = require('./helpers/runSeeders');
const UserFactory = require('./factories/user');

let loggedAsUser;
let loggedAsAdmin;
const users = [];

describe('UserController', () => {
    beforeAll(async () => {
        try {
            await runSeeders();
        } catch (error) {}
        loggedAsAdmin = await loginAsAdmin(request);
        loggedAsUser = await loginAsUser(request);

        users.push(await UserFactory.create());
    });

    describe('POST /users', () => {
        it('create user', async (done) => {
            const userParams = UserFactory.generate();

            const { body } = await request.post(`/users`).send(userParams);

            expect(body.email).toEqual(userParams.email.toLowerCase());

            done();
        });

        it('return error when user already exist', async (done) => {
            const userParams = await UserFactory.generate({
                email: 'admin@estimoteapp.test'
            });

            const { body } = await request.post(`/users`).send(userParams);

            expect(body).toHaveProperty('errors');
            expect(body.errors).toContainEqual({
                param: 'email',
                message: 'Email address already exists!'
            });

            done();
        });

        it('return error 400 when create user without param email', async (done) => {
            const userParams = await UserFactory.generate({
                email: null
            });

            const { status } = await request.post(`/users`).send(userParams);

            expect(status).toEqual(HttpStatuses.BAD_REQUEST);

            done();
        });

        it('return error 400 when create user without param firstName', async (done) => {
            const userParams = await UserFactory.generate({
                firstName: null
            });

            const { status, body } = await request
                .post(`/users`)
                .send(userParams);

            expect(status).toEqual(HttpStatuses.BAD_REQUEST);
            expect(body.errors).toContainEqual({
                param: 'firstName',
                message: 'Should not be empty'
            });

            done();
        });

        it('return error 400 when create user without param lastName', async (done) => {
            const userParams = await UserFactory.generate({
                lastName: null
            });

            const { status, body } = await request
                .post(`/users`)
                .send(userParams);

            expect(status).toEqual(HttpStatuses.BAD_REQUEST);
            expect(body.errors).toContainEqual({
                param: 'lastName',
                message: 'Should not be empty'
            });

            done();
        });

        it('return error 400 when create user without param password', async (done) => {
            const userParams = await UserFactory.generate({
                password: null
            });

            const { status } = await request.post(`/users`).send(userParams);

            expect(status).toEqual(HttpStatuses.BAD_REQUEST);

            done();
        });
    });

    describe('GET /users', () => {
        it('get all employees as admin', async (done) => {
            const { token } = loggedAsAdmin.body;

            const { status } = await request
                .get(`/users`)
                .set('Authorization', 'Bearer ' + token);

            expect(status).toEqual(HttpStatuses.OK);

            done();
        });

        it('return error 403 try to get users as USER', async (done) => {
            const { token } = loggedAsUser.body;

            const { status } = await request
                .get(`/users`)
                .set('Authorization', 'Bearer ' + token);

            expect(status).toEqual(HttpStatuses.FORBIDDEN);

            done();
        });
    });

    describe('GET /users/id', () => {
        it('get a single user as admin', async (done) => {
            const { token } = loggedAsAdmin.body;

            const { body } = await request
                .get(`/users/${users[0].id}`)
                .set('Authorization', 'Bearer ' + token);

            expect(body).toHaveProperty('email');
            expect(body.email).toEqual(users[0].email);

            done();
        });

        it('return error 403 when trying get a single user as USER', async (done) => {
            const { token } = loggedAsUser.body;

            const { status, body } = await request
                .get(`/users/${users[0].id}`)
                .set('Authorization', 'Bearer ' + token);

            expect(status).toEqual(HttpStatuses.FORBIDDEN);

            done();
        });

        it('get logged user data as user', async (done) => {
            const { token, user } = loggedAsUser.body;

            const { status } = await request
                .get(`/users/${user.id}`)
                .set('Authorization', 'Bearer ' + token);

            expect(status).toEqual(HttpStatuses.OK);

            done();
        });

        it('returns 404 if user hasnt been found /users/id', async (done) => {
            const { token } = loggedAsAdmin.body;

            const { status } = await request
                .get(`/users/99999999999999`)
                .set('Authorization', 'Bearer ' + token);

            expect(status).toEqual(HttpStatuses.NOT_FOUND);

            done();
        });
    });

    // describe('PUT /employees/{id}', () => {
    //     it('returns 400 during UPDATE as ADMIN when email already exists', async (done) => {
    //         const { token } = loggedAsAdmin.body;
    //         const userData = await UserFactory.generate({
    //             email: employees[0].email
    //         });

    //         const { body } = await request
    //             .put(`/employees/${employees[0].id}`)
    //             .set('Authorization', token)
    //             .send(userData);

    //         expect(body).toHaveProperty('errors');
    //         expect(body.errors).toContainEqual({
    //             param: 'email',
    //             message: 'Email address already exists!'
    //         });

    //         done();
    //     });

    //     it('return error 404 when employee not exist as admin', async (done) => {
    //         const { token } = loggedAsAdmin.body;

    //         const userData = await UserFactory.generate();

    //         const { status } = await request
    //             .put(`/employees/999999999`)
    //             .set('Authorization', token)
    //             .send(userData);

    //         expect(status).toEqual(HttpStatuses.NOT_FOUND);

    //         done();
    //     });

    //     it('return error 401 update employees as employee', async (done) => {
    //         const { token } = loggedAsEmployee.body;
    //         const userData = await UserFactory.generate({
    //             email: employees[0].email
    //         });

    //         const response = await request
    //             .put(`/employees/${employees[0].id}`)
    //             .set('Authorization', token)
    //             .send(userData);

    //         expect(response.status).toEqual(HttpStatuses.FORBIDDEN);

    //         done();
    //     });

    //     it('return error 400 update employees without param email', async (done) => {
    //         const { token } = loggedAsAdmin.body;
    //         const userData = await UserFactory.generate({
    //             email: null
    //         });

    //         const response = await request
    //             .put(`/employees/${employees[0].id}`)
    //             .set('Authorization', token)
    //             .send(userData);

    //         expect(response.status).toEqual(HttpStatuses.BAD_REQUEST);

    //         done();
    //     });

    //     it('return error 400 update employees without param firstName', async (done) => {
    //         const { token } = loggedAsAdmin.body;
    //         const userData = await UserFactory.generate({
    //             email: employees[0].email,
    //             firstName: null
    //         });

    //         const response = await request
    //             .put(`/employees/${employees[0].id}`)
    //             .set('Authorization', token)
    //             .send(userData);

    //         expect(response.status).toEqual(HttpStatuses.BAD_REQUEST);

    //         done();
    //     });

    //     it('return error 400 update employees without param lastName', async (done) => {
    //         const { token } = loggedAsAdmin.body;
    //         const userData = await UserFactory.generate({
    //             email: employees[0].email,
    //             lastName: null
    //         });

    //         const response = await request
    //             .put(`/employees/${employees[0].id}`)
    //             .set('Authorization', token)
    //             .send(userData);

    //         expect(response.status).toEqual(HttpStatuses.BAD_REQUEST);

    //         done();
    //     });

    //     it('return error 400 update employees without param dayOfBirth', async (done) => {
    //         const { token } = loggedAsAdmin.body;
    //         const userData = await UserFactory.generate({
    //             email: employees[0].email,
    //             dayOfBirth: null
    //         });

    //         const response = await request
    //             .put(`/employees/${employees[0].id}`)
    //             .set('Authorization', token)
    //             .send(userData);

    //         expect(response.status).toEqual(HttpStatuses.BAD_REQUEST);

    //         done();
    //     });
    // });

    // describe('DELETE /employees/{id}', () => {
    //     it('return 204 when user doesnt exist as admin', async (done) => {
    //         const { token } = loggedAsAdmin.body;

    //         const response = await request
    //             .delete(`/employees/999999999`)
    //             .set('Authorization', token);

    //         expect(response.status).toEqual(HttpStatuses.NO_CONTENT);

    //         done();
    //     });

    //     it('return error 401 when thying delete user as employee', async (done) => {
    //         const { token } = loggedAsEmployee.body;

    //         const response = await request
    //             .delete(`/employees/${employees[0].id}`)
    //             .set('Authorization', token);

    //         expect(response.status).toEqual(HttpStatuses.FORBIDDEN);

    //         done();
    //     });

    //     it('delete user as admin', async (done) => {
    //         const { token } = loggedAsAdmin.body;

    //         const response = await request
    //             .delete(`/employees/${employees[0].id}`)
    //             .set('Authorization', token);

    //         expect(response.status).toEqual(HttpStatuses.NO_CONTENT);

    //         done();
    //     });

    //     it('return error 401 when unauthorized', async (done) => {
    //         const response = await request.delete(
    //             `/employees/${employees[0].id}`
    //         );

    //         expect(response.status).toEqual(HttpStatuses.UNAUTHORIZED);

    //         done();
    //     });
    // });
});
