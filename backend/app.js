const express = require('express');
const app = express();
const bodyParser = require('body-parser');
const di = require('./di');
app.set('di', di);

app.use(
    bodyParser.urlencoded({
        extended: true
    })
);

app.use(bodyParser.json());

const routes = require('./routes')(di);

app.use(routes);

const port = process.env.PORT || 3001;
app.listen(port, () => console.log(`Working on port ${port}`));
