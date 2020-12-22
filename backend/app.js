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

const server = require('http').createServer(app);

var io = require('socket.io')(server);

const routes = require('./routes')(di, io);

app.use(routes);

module.exports = server;
