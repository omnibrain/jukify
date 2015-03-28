'use strict';

var mongoose = require('mongoose'),
    Schema = mongoose.Schema;

var SongSchema = new Schema({
  title: String,
  album: String,
	artist: String,
	length: Number,
  jukebox: String,
	votes: { type: Number, default: 0 },
	date: { type: Date, default: Date.now }
});

module.exports = mongoose.model('Song', SongSchema);
