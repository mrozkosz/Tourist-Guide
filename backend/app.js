const express = require('express');
const app = express();
const bodyParser = require('body-parser');
const fileUpload = require('express-fileupload');

const di = require('./di');

app.set('di', di);

app.use(
    bodyParser.urlencoded({
        extended: true
    })
);

app.use(bodyParser.json());

app.use(fileUpload());

app.use(express.static('../public'));

//require('./plugins/cors')(app);

const server = require('http').createServer(app);

var io = require('socket.io')(server);

const routes = require('./routes')(di, io);

app.use(routes);

// const connections = [];

// io.on('connection', (socket) => {
//     connections.push(socket);
//     console.log(socket.id);

//     socket.on('disconnect', (data) => {
//         connections.splice(connections.indexOf(socket), 1);
//         console.log('disconnected');
//     });

//     socket.on('message', (data) => {
//         console.log(data);
//         io.emit('ios', { msg: 'ddeweewfwefwe' });
//     });
// });

module.exports = server;
