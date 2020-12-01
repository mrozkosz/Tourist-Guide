const WebSocketServer = require('ws').Server;

module.exports = (http) => {
    const wss = new WebSocketServer({
        server: http
    });

    return wss;
};
