module.exports = async (request) => {
    const credentials = {
        email: 'user@estimoteapp.test',
        password: 'password'
    };

    return await request.post('/login').send(credentials);
};
