const express = require('express');
const router = express.Router();
const decodeToken = require('../helpers/decodeToken');

module.exports = (di, io) => {
    const commentController = di.get('controller.comment');

    connections = new Set();

    io.on('connection', (socket) => {
        socket.on('join_room', (pleaceId) => {
            socket.join('room' + pleaceId);
        });

        socket.on('allComments', async ({ pleaceId }) => {
            const allComments = await commentController.show(pleaceId);

            if (allComments) {
                const { rows } = allComments;

                socket.emit('comments', { comments: rows });
            }
        });

        socket.on('message', async ({ pleaceId, message, token }) => {
            console.log(token);
            const decodedToken = decodeToken(token);

            if (!decodedToken) {
                return;
            }

            await commentController.create(pleaceId, message, decodedToken.id);

            const allComments = await commentController.show(pleaceId);

            if (allComments) {
                const { rows } = allComments;

                io.to('room' + pleaceId).emit('comments', { comments: rows });
            }
        });
    });

    return router;
};
