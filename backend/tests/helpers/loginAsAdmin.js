module.exports = async (request) => {
    const credentials = {
        email: 'admin@estimoteapp.test',
        password: 'password'
    };

    return await request.post('/login').send(credentials);
};
