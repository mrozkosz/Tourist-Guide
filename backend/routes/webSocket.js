const express = require('express');
const router = express.Router();
const broadcast = require('../helpers/broadcast');
const decodeToken = require('../helpers/decodeToken');

module.exports = (di, wss) => {
    const commentController = di.get('controller.comment');

    wss.on('connection', function connection(ws, req) {
        ws.rooms = new Set();
        ws.on('message', async function (message) {
            try {
                pardedMessage = JSON.parse(message);
            } catch (error) {
                console.error(error);
            }

            if (pardedMessage.id) {
                ws.rooms.add(pardedMessage.id);

                const allComments = await commentController.show(
                    pardedMessage.id
                );

                ws.send(JSON.stringify(allComments));
            }

            if (pardedMessage.join) {
                const decodedToken = decodeToken(pardedMessage.token);

                if (!decodedToken) {
                    return;
                }

                ws.rooms.add(pardedMessage.join);

                const createdComment = commentController.create(
                    pardedMessage,
                    decodedToken.user.id
                );

                if (await createdComment) {
                    broadcast(pardedMessage, wss);
                }
            }
        });
    });

    return router;
};
