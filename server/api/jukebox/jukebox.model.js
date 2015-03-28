'use strict';

var mongoose = require('mongoose'),
    Schema = mongoose.Schema,
		slug = require('slug');

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

JukeboxSchema.virtual('slug').get( function () {
	return slug(this.name);
});

module.exports = mongoose.model('Jukebox', JukeboxSchema);
