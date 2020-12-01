module.exports = (message, webSocket) => {
    webSocket.clients.forEach(function (client) {
        if (client.rooms.has(message.join)) {
            client.send(JSON.stringify(message.msg));
        }
    });
};
