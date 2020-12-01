const express = require('express');
const app = express();
const http = require('http').createServer(app);
const bodyParser = require('body-parser');
const fileUpload = require('express-fileupload');
const wss = require('./plugins/webSocket')(http);

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

const routes = require('./routes')(di, wss);

app.use(routes);

require('./plugins/cors')(app);

const port = process.env.PORT || 3001;
http.listen(port, () => console.log(`Working on port ${port}`));
