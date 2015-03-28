/**
 * Broadcast updates to client when the model changes
 */

'use strict';

var Jukebox = require('./jukebox.model');

exports.register = function(socket) {
  Jukebox.schema.post('save', function (doc) {
    onSave(socket, doc);
  });
  Jukebox.schema.post('remove', function (doc) {
    onRemove(socket, doc);
  });
}

function onSave(socket, doc, cb) {
  socket.emit('jukebox:save', doc);
}

function onRemove(socket, doc, cb) {
  socket.emit('jukebox:remove', doc);
}
