'use strict';

var mongoose = require('mongoose'),
    Schema = mongoose.Schema;

var SongSchema = new Schema({
  title: String,
  album: String,
	artist: String,
	length: Number,
	cover: String,
	uri: String,
  _jukebox: { type: Schema.Types.ObjectId, ref: 'Jukebox' },
	votes: { type: Number, default: 0 },
	played: { type: Boolean, default: false },
	date: { type: Date, default: Date.now }
});

module.exports = mongoose.model('Song', SongSchema);
