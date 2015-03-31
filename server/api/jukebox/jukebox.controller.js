'use strict';

var _ = require('lodash');
var Jukebox = require('./jukebox.model');

// Get list of jukeboxs
exports.index = function(req, res) {
  Jukebox.find(function (err, jukeboxs) {
    if(err) { return handleError(res, err); }
    return res.json(200, jukeboxs);
  });
};

// Get a single jukebox
exports.show = function(req, res) {
  Jukebox.findById(req.params.id, function (err, jukebox) {
    if(err) { return handleError(res, err); }
    if(!jukebox) { return res.send(404); }
    return res.json(jukebox);
  });
};

// Query a single jukebox
exports.query = function(req, res) {
	Jukebox.findOne(req.body, function (err, jukebox) {
    if(err) { return handleError(res, err); }
    if(!jukebox) { return res.send(404); }
    return res.json(jukebox);
	});
};

// Creates a new jukebox in the DB.
exports.create = function(req, res) {
  Jukebox.create(req.body, function(err, jukebox) {
    if(err) { return handleError(res, err); }
    return res.json(201, jukebox);
  });
};

// Updates an existing jukebox in the DB.
exports.update = function(req, res) {
  if(req.body._id) { delete req.body._id; }
  Jukebox.findById(req.params.id, function (err, jukebox) {
    if (err) { return handleError(res, err); }
    if(!jukebox) { return res.send(404); }
    var updated = _.merge(jukebox, req.body);
    updated.save(function (err) {
      if (err) { return handleError(res, err); }
      return res.json(200, jukebox);
    });
  });
};

// Deletes a jukebox from the DB.
exports.destroy = function(req, res) {
  Jukebox.findById(req.params.id, function (err, jukebox) {
    if(err) { return handleError(res, err); }
    if(!jukebox) { return res.send(404); }
    jukebox.remove(function(err) {
      if(err) { return handleError(res, err); }
      return res.send(204);
    });
  });
};

function handleError(res, err) {
  return res.send(500, err);
}

