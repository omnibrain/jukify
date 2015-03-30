'use strict';

var mongoose = require('mongoose'),
    Schema = mongoose.Schema,
		urlslug = require('mongoose-url-slugs');

var JukeboxSchema = new Schema({
  name: String,
	address: String,
	lat: Number,
	lng: Number,
  info: String,
	date: { type: Date, default: Date.now }
},{
    toObject: { virtuals: true },
    toJSON: { virtuals: true }
});

JukeboxSchema.plugin(urlslug('name'));

module.exports = mongoose.model('Jukebox', JukeboxSchema);
